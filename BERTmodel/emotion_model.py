import tensorflow as tf
import numpy as np
from keras.models import load_model
from transformers import DistilBertTokenizer

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
        prediction = self.model.predict(input_ids, verbose=1)
        for i in prediction["logits"] :
            logits = np.array(i)
            softmax_scores = np.exp(logits) / np.sum(np.exp(logits))
            summarize_emotion.append(softmax_scores)
        return summarize_emotion
            
    def analyze_emotion(self, input_sentence) :
        result = self.prob_emotion(input_sentence)
        
        for i in result :
            print(i)