import numpy as np
import re
import json
from konlpy.tag import Okt
from keras.preprocessing.text import Tokenizer
from keras.preprocessing.sequence import pad_sequences
from keras.models import load_model
import pickle

okt = Okt()
tokenizer = Tokenizer()


class EmotionAnalysis:
    def __init__(self):
        self.model = load_model('model/')
        self.model.load_weights('model/data/DATA_OUT/cnn_classifier_kr/weights.h5')

    def analyze_emotion(self, input_sentence):
        with open('model/data/CLEAN_DATA/data_configs.json', 'r') as f:
            prepro_configs = json.load(f)
        tokenizer.fit_on_texts(prepro_configs['vocab'])

        sentence = re.sub(r'[^ㄱ-ㅎㅏ-ㅣ가-힣\\s ]', '', input_sentence)
        stopwords = ['은', '는', '이', '가', '하', '아', '것', '들', '의', '있', '되', '수', '보', '주', '등', '한']
        sentence = okt.morphs(sentence, stem=True)
        sentence = [word for word in sentence if not word in stopwords]
        vector = tokenizer.texts_to_sequences(sentence)
        pad_new = pad_sequences(vector, maxlen=8)

        predictions = self.model.predict(pad_new)

        emotion_labels = ['불안', '분노', '기쁨']

        def summarize_emotion(emotions, threshold=0.35):
            summary = []
            for e in emotions:
                dominant_emotion = np.argmax(e)
                if e[dominant_emotion] > threshold:
                    summary.append(emotion_labels[dominant_emotion])
            return summary

        overall_summary = summarize_emotion(predictions)
        emotion_counts = {emotion: overall_summary.count(emotion) for emotion in emotion_labels}
        return emotion_counts