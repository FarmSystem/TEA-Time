import numpy as np
import pandas as pd
import re
import os
import json

from konlpy.tag import Okt
from keras.preprocessing.sequence import pad_sequences
from keras.utils import to_categorical
from keras.preprocessing.text import Tokenizer

train_data = pd.read_csv('new_model/data/TRAINSET.txt', header=0, delimiter='\t', quoting=3, encoding='cp949')
print(train_data['발화'][:10])

def preprocessing(review, okt, remove_stopwords = False, stop_words = []):
    review_text = re.sub('[^가-힣ㄱ-ㅎㅏ-ㅣ\\s]','', review)
    word_review = okt.morphs(review_text, stem=True)

    if remove_stopwords:
        word_review = [token for token in word_review if not token in stop_words]
    return word_review

stop_words = ['은', '는', '이', '가', '하', '아', '것', '들', '의', '있', '되', '수', '보', '주', '등', '한']
okt = Okt()
clean_train_review = []

for review in train_data['발화']:
    if type(review) == str:
        clean_train_review.append(preprocessing(review, okt, remove_stopwords=True, stop_words=stop_words))
    else:
        clean_train_review.append([])

test_data = pd.read_csv('new_model/data/TESTCASE.txt', header=0, delimiter='\t', quoting=3, encoding='cp949')
clean_test_review = []

for review in test_data['발화']:
    if type(review) == str:
        clean_test_review.append(preprocessing(review, okt, remove_stopwords=True, stop_words=stop_words))
    else:
        clean_test_review.append([])

tokenizer = Tokenizer()
tokenizer.fit_on_texts(clean_train_review)
train_sequences = tokenizer.texts_to_sequences(clean_train_review)
test_sequences = tokenizer.texts_to_sequences(clean_test_review)

word_vocab = tokenizer.word_index
train_inputs = pad_sequences(train_sequences, maxlen=8)
train_labels = to_categorical(train_data['감정'])

test_inputs = pad_sequences(test_sequences, maxlen=8)
test_label_data = np.array(test_data['감정'])
test_labels = to_categorical(test_label_data, num_classes=3)

data_configs = dict()
data_configs['vocab'] = word_vocab
data_configs['vocab_size'] = len(word_vocab)+1

if not os.path.exists('new_model/data/clean_data'):
    os.makedirs('new_model/data/clean_data')

train_input_data = 'new_model/data/clean_data/nsmc_train_input.npy'
train_label_data = 'new_model/data/clean_data/nsmc_train_label.npy'
test_input_data = 'new_model/data/clean_data/nsmc_test_input.npy'
test_label_data = 'new_model/data/clean_data/nsmc_test_label.npy'

np.save(train_input_data, train_inputs)
np.save(train_label_data, train_labels)

np.save(test_input_data, test_inputs)
np.save(test_label_data, test_labels)

json.dump(data_configs, open('new_model/data/clean_data/data_configs.json', 'w'), ensure_ascii=False)

print('preprocessing done')