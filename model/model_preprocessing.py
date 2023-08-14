# 전처리
import numpy as np
import pandas as pd
import re
import os
import json
from konlpy.tag import Okt
from keras.preprocessing.text import Tokenizer
from keras.preprocessing.sequence import pad_sequences
from keras.utils import to_categorical

DATA_PATH = 'model/data/'
train_data = pd.read_csv(DATA_PATH + 'TRAINSET.txt', header = 0, delimiter = '\t', quoting=3, encoding='cp949')

#전처리 함수 만들기
def preprocessing(review, okt, remove_stopwords = False, stop_words = []):
  #함수인자설명
  # review : 전처리할 텍스트
  # okt : okt객체를 반복적으로 생성하지 않고 미리 생성 후 인자로 받음
  # remove_stopword : 불용어를 제거할지 여부 선택. 기본값 False
  # stop_words : 불용어 사전은 사용자가 직접 입력, 기본값 빈 리스트

  #1. 한글 및 공백 제외한 문자 모두 제거
  review_text = re.sub('[^가-힣ㄱ-ㅎㅏ-ㅣ\\s]','',review)
  
  #2. okt 객체를 활용하여 형태소 단어로 나눔
  word_review = okt.morphs(review_text,stem=True)

  if remove_stopwords:
    #3. 불용어 제거
    word_review = [token for token in word_review if not token in stop_words]
  return word_review

# 전체 텍스트 전처리
stop_words = ['은','는','이','가','하','아','것','들','의','있','되','수','보','주','등','한']
okt = Okt()
clean_train_review = []

for review in train_data['발화']:
  # 데이터가 문자열인 경우만 전처리 진행
  if type(review) == str:
    clean_train_review.append(preprocessing(review, okt, remove_stopwords=True, stop_words= stop_words))
  else:
    clean_train_review.append([]) # str이 아닌 행은 빈칸으로 놔두기  
    
# 테스트 리뷰도 동일하게 전처리
test_data = pd.read_csv(DATA_PATH + 'TESTCASE.txt', header = 0, delimiter='\t', quoting=3, encoding='cp949')

clean_test_review = []
for review in test_data['발화']:
  if type(review) == str:
    clean_test_review.append(preprocessing(review, okt, remove_stopwords=True, stop_words=stop_words))
  else:
    clean_test_review.append([])

# 수정
# 인덱스 벡터 변환 후 일정 길이 넘어가거나 모자라는 리뷰 패딩처리
tokenizer = Tokenizer()
tokenizer.fit_on_texts(clean_train_review)
train_sequences = tokenizer.texts_to_sequences(clean_train_review)
test_sequences = tokenizer.texts_to_sequences(clean_test_review)

word_vocab = tokenizer.word_index # 단어사전형태
MAX_SEQUENCE_LENGTH = 8 # 문장 최대 길이

# 학습 데이터 / post padding > pre padding
train_inputs = pad_sequences(train_sequences,maxlen=MAX_SEQUENCE_LENGTH) 
# 학습 데이터 라벨 벡터화
train_labels = np.array(train_data['감정'])

# 평가 데이터 / post padding > pre padding
test_inputs = pad_sequences(test_sequences,maxlen=MAX_SEQUENCE_LENGTH)
# 평가 데이터 라벨 벡터화
# 감정 분류에 따라 One-hot encoding
test_label_data = np.array(test_data['감정'])
test_labels = to_categorical(test_label_data, num_classes=3) # 수정할 부분 : 출력 차원

DEFAULT_PATH  = 'model/data/' # 경로지정
DATA_PATH = 'CLEAN_DATA/' #.npy파일 저장 경로지정
TRAIN_INPUT_DATA = 'nsmc_train_input.npy' # 학습 데이터 입력
TRAIN_LABEL_DATA = 'nsmc_train_label.npy' # 학습 데이터 레이블
TEST_INPUT_DATA = 'nsmc_test_input.npy' # 테스트 데이터 입력
TEST_LABEL_DATA = 'nsmc_test_label.npy' # 테스트 데이터 레이블
DATA_CONFIGS = 'data_configs.json' # 데이터 사전

# word_vocab과 단어의 개수를 저장
data_configs={} 
data_configs['vocab'] = word_vocab
data_configs['vocab_size'] = len(word_vocab) + 1

#전처리한 데이터들 파일로저장
if not os.path.exists(DEFAULT_PATH + DATA_PATH):
  os.makedirs(DEFAULT_PATH+DATA_PATH)

#전처리 학습데이터 넘파이로 저장
np.save(open(DEFAULT_PATH+DATA_PATH+TRAIN_INPUT_DATA,'wb'),train_inputs)
np.save(open(DEFAULT_PATH+DATA_PATH+TRAIN_LABEL_DATA,'wb'),train_labels)
#전처리 테스트데이터 넘파이로 저장
np.save(open(DEFAULT_PATH+DATA_PATH+TEST_INPUT_DATA,'wb'),test_inputs)
np.save(open(DEFAULT_PATH+DATA_PATH+TEST_LABEL_DATA,'wb'),test_labels)

#데이터 사전 json으로 저장
json.dump(data_configs,open(DEFAULT_PATH + DATA_PATH + DATA_CONFIGS,'w'),ensure_ascii=False)