import pickle


def get_emotion(sentence: str):
    with open('new_model/emotion_analyzer.pkl', 'rb') as f:
        loaded_analyzer = pickle.load(f)
    result = loaded_analyzer.analyze_emotion(sentence)
    return result


if __name__ == "__main__":
    print(get_emotion("학교에서 칭찬을 받아서 기분이 너무 좋아"))