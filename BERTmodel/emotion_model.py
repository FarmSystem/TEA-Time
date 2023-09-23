import tensorflow as tf
import numpy as np
import pandas as pd
import torch
import torch.nn.functional as F
from keras.models import load_model
from transformers import BertModel, BertTokenizer, BertForSequenceClassification
from transformers import DistilBertTokenizer, TFDistilBertForSequenceClassification

model_name = "distilbert-base-multilingual-cased"
tokenizer = DistilBertTokenizer.from_pretrained(model_name)

class EmotionAnalysis :
    def __init__(self) :
        self.model = load_model('BERTmodel/model/')
        self.model.load_weights('BERTmodel/model.h5/tf_model.h5')
    
    def BERTtokenizer(self, data, tokenizer):
        input_ids = []
        attention_masks = []
        for text in data:
            tokenized_text = tokenizer.encode_plus(text,
                                                max_length=128,
                                                add_special_tokens = True,
                                                pad_to_max_length=True,
                                                return_attention_mask=True,
                                                truncation=True)
            input_ids.append(tokenized_text['input_ids'])
            attention_masks.append(tokenized_text['attention_mask'])

        return input_ids, attention_masks
    
        # 입력 데이터를 BERT 모델에 전달하고 확률 분포 반환하는 함수
    def analyze_emotion(self, input_ids, attention_masks):
        # 입력 데이터를 텐서로 변환
        input_ids = tf.constant(input_ids)
        attention_masks = tf.constant(attention_masks)
        
        # BERT 모델에 입력 데이터 전달
        outputs = self.model(input_ids, attention_masks)
        # 소프트맥스 함수를 사용하여 확률 분포 계산
        softmax_output = F.softmax(outputs.logits, dim=1)
        
        # 확률 분포 반환
        return softmax_output.tolist()[0]
        
    def prob_emotion(self, input_sentence) :
        input_ids, attention_masks = self.BERTtokenizer(input_sentence, tokenizer)
        
        emotion_list = []
        for id, mask in zip(input_ids, attention_masks) :
            emotion_list.append(self.analyze_emotion(id, mask))
            
        return emotion_list
            
    def print_emotion(self, input_sentence) :
        result = self.prob_emotion(input_sentence)
        
        for i in result :
            print(i)