import pickle
from emotion_model import EmotionAnalysis

analyzer = EmotionAnalysis()

with open('new_model/emotion_analyzer.pkl', 'wb') as f:
    pickle.dump(analyzer, f)
