import numpy as np
import re
import json
from konlpy.tag import Okt
from keras.preprocessing.sequence import pad_sequences
from keras.models import load_model
from keras.preprocessing.text import Tokenizer

class EmotionAnalysis:
    def __init__(self):
        self.okt = Okt()
        self.tokenizer = Tokenizer()
        self.load_tokenizer()

    def load_tokenizer(self):
        DATA_CONFIGS = 'data_configs.json'
        prepro_configs = json.load(open('./model/data/CLEAN_DATA/' + DATA_CONFIGS, 'r'))
        self.tokenizer.fit_on_texts(prepro_configs['vocab'])

    def preprocess_sentence(self, sentence):
        sentence = re.sub(r'[^ㄱ-ㅎㅏ-ㅣ가-힣\\s ]', '', sentence)
        stopwords = ['은', '는', '이', '가', '하', '아', '것', '들', '의', '있', '되', '수', '보', '주', '등', '한'] # add stopwords if you have something to add
        sentence = self.okt.morphs(sentence, stem=True)  # Tokenize
        sentence = [word for word in sentence if word not in stopwords]  # remove stopwords
        return sentence

    def analyze_emotion(self, input_sentence):
        MAX_LENGTH = 8  # maximum sentence length
        sentence = self.preprocess_sentence(input_sentence)
        vector = self.tokenizer.texts_to_sequences([sentence])
        pad_new = pad_sequences(vector, maxlen = MAX_LENGTH)  # padding

        model = load_model('./model/')
        model.load_weights('./model/data/DATA_OUT/cnn_classifier_kr/weights.h5')
        predictions = model.predict(pad_new)

        # given result
        emotions = np.array(predictions)

        # emotion label
        emotion_labels = ['불안', '분노', '기쁨']

        def summarize_emotion(emotions, threshold=0.35):  # set threshold
            summary = []
            for e in emotions:
                dominant_emotion = np.argmax(e)  # index of the highest scoring emotion
                if e[dominant_emotion] > threshold:  # only consider scores above the threshold
                    summary.append(emotion_labels[dominant_emotion])
            return summary

        # Overall mood summary
        overall_summary = summarize_emotion(emotions)

        # Calculate the summarized sentiment frequency
        emotion_counts = {emotion: overall_summary.count(emotion) for emotion in emotion_labels}
        return emotion_counts

# Example usage
if __name__ == "__main__":
    analysis = EmotionAnalysis()
    result = analysis.analyze_emotion("It feels so good to get a compliment at school")
    print(result)
