import tensorflow as tf
import numpy as np
from konlpy.tag import Kkma
from transformers import DistilBertTokenizer, TFDistilBertForSequenceClassification

kkma = Kkma()
model_name = "distilbert-base-multilingual-cased"
model = TFDistilBertForSequenceClassification.from_pretrained(
    model_name,
    num_labels=5
)
tokenizer = DistilBertTokenizer.from_pretrained(model_name)


class EmotionModel:
    def __init__(self):
        self.model = model
        self.model.load_weights('weights.h5')

    """
    BERT tokenizer를 이용하여 문장을 토큰화
    """
    @staticmethod
    def bert_tokenizer(data):
        input_ids = tokenizer(data,
                              truncation=True,
                              padding=True)
        input_ids = tf.data.Dataset.from_tensor_slices((dict(input_ids),)).batch(32)
        return input_ids

    """
    각 문장별 어떤 감정을 내포하고 있는지 분류하고 summarize_emotion 리스트를 반환
    """
    def prob_emotion(self, input_sentence):
        input_ids = self.bert_tokenizer(input_sentence)

        summarize_emotion = []
        emotion_lst = ["기쁨", "당황", "분노", "불안", "슬픔"]
        prediction = self.model.predict(input_ids, verbose=1)
        for sent, emotion in zip(input_sentence, prediction["logits"]):
            logits = np.array(emotion)
            softmax_scores = np.exp(logits) / np.sum(np.exp(logits))
            dominant_emotion = np.argmax(softmax_scores)
            summarize_emotion.append(
                [sent, emotion_lst[dominant_emotion], format(softmax_scores[dominant_emotion] * 100, ".2f")])

        return summarize_emotion

    @staticmethod
    def print_emotion(sentence):
        return_list = []
        for text in sentence:
            return_list.append(f'"{text[0]}"은 {text[2]}%의 확률로 {text[1]}을 나타내는 문장입니다.')
        return return_list

    """
    주어진 전체 문장을 kkma 객체를 이용하여 문장별로 분류
    """
    def analyze_emotion(self, input_sentence):
        sentence = kkma.sentences(input_sentence)
        sentence = self.prob_emotion(sentence)

        return self.print_emotion(sentence)
