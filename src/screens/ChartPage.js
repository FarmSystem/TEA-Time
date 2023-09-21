import React from "react";
import {
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  ScrollView,
} from "react-native";
import styled from "styled-components/native";
import { BarChart, LineChart, PieChart } from "react-native-gifted-charts";

const LineData = [
  { value: 20, label: "1" },
  { value: 30, label: "3" },
  { value: -23, label: "4" },
  { value: 40, label: "5" },
  { value: -16, label: "7" },
  { value: 40, label: "10" },
  { value: 15, label: "12" },
  { value: 30, label: "13" },
  { value: -23, label: "14" },
  { value: 40, label: "15" },
  { value: -16, label: "17" },
  { value: 40, label: "20" },
];

const Container = styled.View`
  flex: 1;
  justify-content: flex-start; /* flex-start로 변경하여 상단에서부터 시작하도록 설정 */
  align-items: center;
  background-color: #fff9f2;
`;

const Section1 = styled.View`
  flex: 1;
  justify-content: center;
  align-items: center;
`;

const Section2 = styled.View`
  flex: 1;
  background-color: white;
  padding: 20px;
`;

const Section3 = styled.View`
  flex: 3; /* 그래프 차트가 더 많은 공간을 차지하도록 설정 */
`;

const Section4 = styled.View`
  flex: 0.5; /* 작은 섹션으로 설정 */
  background-color: white;
  justify-content: center;
  align-items: center;
`;

export default function ChartPage() {
  // 평균 계산 로직을 추가
  const average =
    LineData.reduce((sum, data) => sum + data.value, 0) / LineData.length;

  return (
    <Container>
      <Section1>
        <Text>감정 분석 차트</Text>
      </Section1>

      <Section2>
        <View
          style={{
            flexDirection: "row",
            justifyContent: "space-around",
          }}
        >
          <TouchableOpacity>
            <Text>월별 차트</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text>일별 차트</Text>
          </TouchableOpacity>
        </View>
      </Section2>

      <Section3>
        <ScrollView scrollEventThrottle={15}>
          <LineChart
            areaChart
            data={LineData}
            startFillColor="rgb(46, 217, 255)"
            startOpacity={0.8}
            endFillColor="rgb(203, 241, 250)"
            endOpacity={0.3}
            scrollEventThrottle={16}
            // pointerConfig={{}}
          />
        </ScrollView>
      </Section3>

      <Section4>
        <Text>평균 점수: {average.toFixed(2)}점</Text>
      </Section4>
    </Container>
  );
}
