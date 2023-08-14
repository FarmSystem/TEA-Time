import pickle

# 피클 파일 로드
def getsentence(sentence) :
    with open('model/emotion_analyzer.pkl', 'rb') as f:
        loaded_analyzer = pickle.load(f)
    # 감정 분석 수행 및 결과 출력
    result = loaded_analyzer.analyze_emotion(sentence)
    
    return result

if __name__ == "__main__" :
    getsentence("기분이 좋은 하루")