# 학습 데이터 불러오기
import tensorflow as tf
import numpy as np
import pandas as pd
import os
import json
from keras.preprocessing.sequence import pad_sequences
from keras.saving import register_keras_serializable
from keras.models import save_model
from keras.utils import to_categorical
from keras.callbacks import EarlyStopping, ModelCheckpoint
from keras import layers
from keras.layers import Dense
from tqdm import tqdm

# 전처리 데이터 불러오기
DATA_PATH = './data/CLEAN_DATA/'
DATA_OUT = './data/DATA_OUT/'
INPUT_TRAIN_DATA = 'nsmc_train_input.npy'
LABEL_TRAIN_DATA = 'nsmc_train_label.npy'
DATA_CONFIGS = 'data_configs.json'

train_input = np.load(open(DATA_PATH + INPUT_TRAIN_DATA,'rb'), allow_pickle=True)
train_input = pad_sequences(train_input, maxlen=train_input.shape[1])
train_label = np.load(open(DATA_PATH + LABEL_TRAIN_DATA,'rb'), allow_pickle=True)
train_label = to_categorical(train_label, num_classes=3) # 수정 부분
prepro_configs = json.load(open(DATA_PATH+DATA_CONFIGS,'r'))

model_name = 'cnn_classifier_kr'
BATCH_SIZE = 128 # BATCH_SIZE 줄여서 그레이디언트 보다 정확하게 업데이트
NUM_EPOCHS = 10
VALID_SPLIT = 0.1 # 학습 데이터 중 검증 데이터로 사용할 비율
MAX_LEN = train_input.shape[1] # train_input의 열의 수 반환. 전처리 과정에서의 MAX_SEQUENCE_LENGTH 값인 8 반환

kargs={
    'model_name': model_name,
    'vocab_size':prepro_configs['vocab_size'],
    'embbeding_size':128, # 임베딩 벡터 수
    'num_filters':200, # 합성곱 필터 수
    'dropout_rate':0.4, # 드롭아웃 비율
    'hidden_dimension':700, # 은닉층
    'output_dimension':3 # 출력층 / 3가지 감정 분류
    }

# CNN 모델 class생성
@register_keras_serializable()
class CNNClassifier(tf.keras.Model):

    def __init__(self, **kargs):
        super(CNNClassifier, self).__init__(name=kargs['model_name'])
        self.embedding = layers.Embedding(input_dim=kargs['vocab_size'], output_dim=kargs['embbeding_size'])
        self.conv_list = [layers.Conv1D(filters=kargs['num_filters'], kernel_size=kernel_size, padding='valid',activation = tf.keras.activations.relu,
                                        kernel_constraint = tf.keras.constraints.MaxNorm(max_value=2)) for kernel_size in [3,4,5]]
        self.pooling = layers.GlobalMaxPooling1D()
        self.dropout = layers.Dropout(kargs['dropout_rate'])
        self.fc1 = layers.Dense(units=kargs['hidden_dimension'],
                                activation = tf.keras.activations.relu,
                                kernel_constraint=tf.keras.constraints.MaxNorm(max_value=2.))
        self.fc2 = layers.Dense(units=kargs['output_dimension'],  # 수정할 부분 : 출력 차원 변경
                                activation=tf.keras.activations.softmax,  # 활성화 함수 변경 / 다중 분류를 위한 softmax
                                kernel_constraint= tf.keras.constraints.MaxNorm(max_value=2.)) # 가중치 제한 3 / 수정할 필요 있음

    def call(self,x):
        x = self.embedding(x)
        x = self.dropout(x)
        x = tf.concat([self.pooling(conv(x)) for conv in self.conv_list], axis = 1)
        x = self.fc1(x)
        x = self.fc2(x)
        return x

# 모델 상세 설정
model = CNNClassifier(**kargs)
model.compile(optimizer=tf.keras.optimizers.Adam(), # Adam 최적화 알고리즘 사용
              loss=tf.keras.losses.CategoricalCrossentropy(),
              metrics=[tf.keras.metrics.CategoricalAccuracy(name='accuracy')])

earlystop_callback = EarlyStopping(monitor='val_accuracy', min_delta=0.0001, patience=2) # 정확도 개선 최소치 및 추가적으로 기다릴 epoch
checkpoint_path = DATA_OUT + model_name + '/weights.h5' # 가중치 이름 / 운영체제 따라 경로 설정 다르게
checkpoint_dir = os.path.dirname(checkpoint_path)

if os.path.exists(checkpoint_dir): # checkpoint_dir 파일 유무 확인
    print("{} -- Folder already exists \n".format(checkpoint_dir))
else:
    os.makedirs(checkpoint_dir, exist_ok=True)
    print("{} -- Folder create complete \n".format(checkpoint_dir))

cp_callback = ModelCheckpoint( # ModelCheckpoint 콜백은 모델의 학습 중간에 가장 좋은 성능을 보인 시점에서의 가중치를 checkpoint_path에 저장
    checkpoint_path, monitor='val_accuracy', verbose=1, save_best_only=True,
    save_weights_only=True
)

# 모델 학습
history = model.fit(train_input, train_label, batch_size=BATCH_SIZE, epochs=NUM_EPOCHS, 
                    validation_split=VALID_SPLIT, callbacks=[earlystop_callback, cp_callback])

save_model(model, './')

# TC
INPUT_TEST_DATA = 'nsmc_test_input.npy'
LABEL_TEST_DATA = 'nsmc_test_label.npy'
SAVE_FILE_NM = 'weights.h5'

test_input = np.load(open(DATA_PATH+INPUT_TEST_DATA,'rb'))
test_input = pad_sequences(test_input,maxlen=test_input.shape[1])
test_label_data = np.load(open(DATA_PATH + LABEL_TEST_DATA, 'rb'))

model.load_weights('./data/DATA_OUT/cnn_classifier_kr/weights.h5')
model.evaluate(test_input, test_label_data)
