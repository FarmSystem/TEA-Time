import pickle
from emotion_model import EmotionAnalysis

analyzer = EmotionAnalysis()
# 피클 파일로 저장
with open('model/emotion_analyzer.pkl', 'wb') as f:
    pickle.dump(analyzer, f)