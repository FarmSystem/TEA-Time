import numpy as np
import re
import json
from konlpy.tag import Okt
from konlpy.tag import Kkma
from keras.preprocessing.text import Tokenizer
from keras.preprocessing.sequence import pad_sequences
from keras.models import load_model

okt = Okt()
kkma = Kkma()
tokenizer = Tokenizer()


class EmotionAnalysis:
    def __init__(self):
        self.model = load_model('model/') # 모델 로드
        self.model.load_weights('model/data/DATA_OUT/cnn_classifier_kr/weights.h5') # 가중치 로드

    def analyze_emotion(self, input_sentence):
        with open('model/data/CLEAN_DATA/data_configs.json', 'r') as f:
            prepro_configs = json.load(f) # 단어 사전 불러오기
        tokenizer.fit_on_texts(prepro_configs['vocab'])

        sentence = kkma.sentences(input_sentence)  # 문장 분리
        stopwords = ['은','는','이','가','하','아','것','들','의','있','되','수','보','주','등','한','을','를','으로','로'] # 제거할 불용어
        sentence_list = []
        for sent in sentence :
            sent = re.sub(r'[^ㄱ-ㅎㅏ-ㅣ가-힣\\s ]', '', sent) # 한글 제외 제거
            sent = okt.morphs(sent, stem=True) # segmentation
            sent = [word for word in sent if not word in stopwords] # 불용어 제거
            sentence_list.append(sent)
            
        vector = tokenizer.texts_to_sequences(sentence_list) # 벡터화
        pad_new = pad_sequences(vector, maxlen=128) # 패딩 / 문장최대길이 조절
        print(len(pad_new))

        predictions = self.model.predict(pad_new) # 전처리 된 문장 모델에 넣고 예측 / 반환값 numpy 배열
        emotion_labels = ['불안', '분노', '기쁨']

        def summarize_emotion(emotions, threshold=0.4): # 임계값 설정
            summary = []
            for e in emotions:
                dominant_emotion = np.argmax(e) # 가장 높은 점수의 감정 인덱스 
                if e[dominant_emotion] > threshold: # 임계값 이상의 점수만을 고려
                    summary.append(emotion_labels[dominant_emotion])
            return summary

        overall_summary = summarize_emotion(predictions) # 전체적인 기분 요약
        emotion_counts = {emotion: overall_summary.count(emotion) for emotion in emotion_labels} # 요약된 감정 빈도 계산
        return emotion_counts