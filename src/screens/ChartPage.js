import { BarChart, LineChart, PieChart } from "react-native-gifted-charts";

import React, { Component, useState } from "react";
import {
  StyleSheet,
  ScrollView,
  Text,
  View,
  Image,
  TouchableOpacity,
} from "react-native";
import styled, { ThemeProvider } from "styled-components/native";

const data = [{ value: 50 }, { value: 80 }, { value: 90 }, { value: 70 }];
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
  justify-content: center;
  align-items: center;
  background-color: #fff9f2;
  heigth: 100;
`;

export default function ChartPage() {
  return (
    <Container
      style={{
        display: "flex",
        flexDirection: "column",
        justifyContent: "flex-start",
      }}
    >
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
    </Container>
  );
}
