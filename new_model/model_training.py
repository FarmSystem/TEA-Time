import tensorflow as tf
import numpy as np
import os
import json
from keras.preprocessing.sequence import pad_sequences
from keras.saving import register_keras_serializable
from keras.models import save_model
from keras.utils import to_categorical
from keras.callbacks import EarlyStopping, ModelCheckpoint
from keras import layers

train_input_data = 'new_model/data/clean_data/nsmc_train_input.npy'
train_label_data = 'new_model/data/clean_data/nsmc_train_label.npy'

train_input = np.load(train_input_data, allow_pickle=True)
train_input = pad_sequences(train_input, maxlen=train_input.shape[1])
train_label = np.load(train_label_data, allow_pickle=True)
prepro_configs = json.load(open('new_model/data/clean_data/data_configs.json', 'r'))

model_name = 'cnn_classifier_kr'
BATCH_SIZE = 512
NUM_EPOCHS = 10
VALID_SPLIT = 0.1
MAX_LEN = train_input.shape[1]

kargs = {
    'model_name': model_name,
    'vocab_size': prepro_configs['vocab_size'],
    'embedding_size': 128,
    'num_filters': 100,
    'dropout_rate': 0.5,
    'hidden_dimension': 250,
    'output_dimension': 1
}


@register_keras_serializable()
class CNNClassifier(tf.keras.Model):
    def __init__(self, **kargs):
        super(CNNClassifier, self).__init__(name=kargs['model_name'])
        self.embedding = layers.Embedding(input_dim=kargs['vocab_size'], output_dim=kargs['embedding_size'])
        self.conv_list = [layers.Conv1D(filters=kargs['num_filters'], kernel_size=kernel_size,
                                        padding='valid', activation=tf.keras.activations.relu,
                                        kernel_constraint=tf.keras.constraints.MaxNorm(max_value=3)) for kernel_size in [3, 4, 5]]
        self.pooling = layers.GlobalMaxPooling1D()
        self.dropout = layers.Dropout(kargs['dropout_rate'])
        self.fc1 = layers.Dense(units=kargs['hidden_dimension'],
                                activation=tf.keras.activations.relu,
                                kernel_constraint=tf.keras.constraints.MaxNorm(max_value=3.))
        self.fc2 = layers.Dense(units=3,
                                activation=tf.keras.activations.softmax,
                                kernel_constraint=tf.keras.constraints.MaxNorm(max_value=3.))

    def call(self, x):
        x = self.embedding(x)
        x = self.dropout(x)
        x = tf.concat([self.pooling(conv(x)) for conv in self.conv_list], axis=-1)
        x = self.fc1(x)
        x = self.fc2(x)
        return x

model = CNNClassifier(**kargs)
model.compile(
    optimizer=tf.keras.optimizers.Adam(),
    loss=tf.keras.losses.CategoricalCrossentropy(),
    metrics=[tf.keras.metrics.CategoricalAccuracy(name='accuracy')]
)

train_label = to_categorical(train_label, num_classes=3)
early_stop_callback = EarlyStopping(monitor='val_accuracy', min_delta=0.0001, patience=2)
checkpoint_path = os.path.join('new_model/data/data_out', model_name, '\weights.h5')
checkpoint_dir = os.path.dirname(checkpoint_path)

if os.path.exists(checkpoint_dir):
    print("{} -- Folder already exists \n".format(checkpoint_dir))
else:
    os.makedirs(checkpoint_dir, exist_ok=True)
    print("{} -- Folder create complete \n".format(checkpoint_dir))

cp_callback = ModelCheckpoint(
    checkpoint_path, monitor='val_accuracy', verbose=1, save_best_only=True, save_weights_only=True
)

history = model.fit(
    train_input, train_label,
    batch_size=BATCH_SIZE, epochs=NUM_EPOCHS,
    validation_split=VALID_SPLIT, callbacks=[early_stop_callback, cp_callback]
)

save_model(model, './new_model')

test_input = np.load('new_model/data/clean_data/nsmc_test_input.npy', allow_pickle=True)
test_input = pad_sequences(test_input, maxlen=test_input.shape[1])
test_label = np.load('new_model/data/clean_data/nsmc_test_label.npy', allow_pickle=True)

model.load_weights(checkpoint_path)
model.evaluate(test_input, test_label)

print('Accuracy: {:.2f}%'.format(model.evaluate(test_input, test_label)[1]*100))