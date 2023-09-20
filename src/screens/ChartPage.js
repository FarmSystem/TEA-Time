import { BarChart, LineChart, PieChart } from "react-native-gifted-charts";

import React, { Component, useState } from "react";
import { StyleSheet, ScrollView, Text, View, Image } from "react-native";

// ...
const data = [{ value: 50 }, { value: 80 }, { value: 90 }, { value: 70 }];

export default function ChartPage() {
  const LineData = [
    { value: 15, label: "1" },
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
  return (
    // <ScrollView>
    //   <Text>Chart List</Text>
    //   <BarChart data={data} />
    //   <LineChart data={data} />
    //   <PieChart data={data} />
    //   {/* // For Horizontal Bar chart, just add the prop horizontal to the{" "} */}
    //   <BarChart />
    //   <BarChart data={data} horizontal />
    //   {/* // For Area chart, just add the prop areaChart to the <LineChart />{" "}
    //   component */}
    //   <LineChart data={data} areaChart />
    //   {/* // For Donut chart, just add the prop donut to the <PieChart /> component */}
    //   <PieChart data={data} donut />
    // </ScrollView>
    <ScrollView scrollEventThrottle={0}>
      <LineChart
        areaChart
        data={LineData}
        startFillColor="rgb(46, 217, 255)"
        startOpacity={0.8}
        endFillColor="rgb(203, 241, 250)"
        endOpacity={0.3}
        pointerConfig={{}}
      />
    </ScrollView>
  );
}
