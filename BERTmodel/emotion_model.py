import tensorflow as tf
import numpy as np
from konlpy.tag import Kkma
from keras.models import load_model
from transformers import DistilBertTokenizer

kkma = Kkma()
model_name = "distilbert-base-multilingual-cased"
tokenizer = DistilBertTokenizer.from_pretrained(model_name)

class EmotionAnalysis :
    def __init__(self) :
        self.model = load_model('BERTmodel/model/')
        self.model.load_weights('BERTmodel/model.h5/tf_model.h5')
    
    def BERTtokenizer(self, data):
        input_ids = tokenizer(data,
                              truncation = True,
                              padding = True)
        input_ids = tf.data.Dataset.from_tensor_slices((dict(input_ids),)).batch(32)
        return input_ids
        
    def prob_emotion(self, input_sentence) :
        input_ids = self.BERTtokenizer(input_sentence)
        
        summarize_emotion = []
        emotion_lst = ["기쁨", "당황", "분노", "불안", "슬픔"]
        prediction = self.model.predict(input_ids, verbose=1)
        for sent, emotion in zip(input_sentence, prediction["logits"]) :
            logits = np.array(emotion)
            softmax_scores = np.exp(logits) / np.sum(np.exp(logits))
            dominant_emotion = np.argmax(softmax_scores) 
            summarize_emotion.append([sent, emotion_lst[dominant_emotion], format(softmax_scores[dominant_emotion]*100,".2f")])
            
        return summarize_emotion
    
    def print_emotion(self, sentence) :
        for text in sentence :
            print(f'"{text[0]}"은 {text[2]}%의 확률로 {text[1]}을 나타내는 문장입니다.')
            
    def analyze_emotion(self, input_sentence) :
        sentence = kkma.sentences(input_sentence)
        sentence = self.prob_emotion(sentence)
        
        self.print_emotion(sentence)