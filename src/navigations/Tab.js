import React from "react";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import {
  // CalendarPage,
  DiaryList,
  Chart,
  Settings,
} from "../screens/Tabscreens";
import { CalendarPage } from "../screens/CalendarPage";
import { MaterialCommunityIcons } from "@expo/vector-icons";
import { StyleSheet, TouchableOpacity, Text, View } from "react-native";
//import IconButton from '../components/IconButton';

const TabIcon = ({ name, size, color }) => {
  return <MaterialCommunityIcons name={name} size={size} color={color} />;
};

const Tab = createBottomTabNavigator();

const styles = StyleSheet.create({
  Container: {
    backgroundColor: "white",
    justifyContent: "space-between",
    alignItems: "flex-end",
    top: 30,
  },
});

/*export const search = () => {
    return (
        <Container>
            <IconButton />
        </Container>
    )
}*/

export const TabNavigation = () => {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        tabBarStyle: { backgroundColor: "#F4E8D1" },
      })}
    >
      <Tab.Screen
        name="Calendar"
        component={CalendarPage}
        options={{
          headerStyle: { backgroundColor: "#F4E8D1" },
          fontWeight: "bold",
          tabBarIcon: (props) => TabIcon({ ...props, name: "calendar" }),
        }}
      />

      <Tab.Screen
        name="DiaryList"
        component={DiaryList}
        options={{
          headerStyle: { backgroundColor: "#F4E8D1" },
          fontWeight: "bold",
          tabBarIcon: (props) =>
            TabIcon({ ...props, name: "file-document-outline" }),
        }}
      />

      <Tab.Screen
        name="Chart"
        component={Chart}
        options={{
          headerStyle: { backgroundColor: "#F4E8D1" },
          fontWeight: "bold",
          tabBarIcon: (props) => TabIcon({ ...props, name: "chart-bar" }),
        }}
      />

      <Tab.Screen
        name="Settings"
        component={Settings}
        options={{
          headerStyle: { backgroundColor: "#F4E8D1" },
          fontWeight: "bold",
          tabBarIcon: (props) => TabIcon({ ...props, name: "account-cog" }),
        }}
      />
    </Tab.Navigator>
  );
};
