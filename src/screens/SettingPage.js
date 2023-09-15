import React, { useState } from "react";
import {
  StyleSheet,
  Switch,
  FlatList,
  Platform,
  TouchableOpacity,
  View,
} from "react-native";
import { Block, Text, theme, Icon } from "galio-framework";

import materialTheme from "../constants/Theme";

export const SettingPage = () => {
  const [selectedDate, setSelectedDate] = useState(null);
  const [switchStates, setSwitchStates] = useState({});

  const toggleSwitch = (switchNumber) => {
    setSwitchStates((prevSwitchStates) => ({
      ...prevSwitchStates,
      [switchNumber]: !prevSwitchStates[switchNumber],
    }));
  };

  const renderItem = ({ item }) => {
    switch (item.type) {
      case "switch":
        return (
          <Block row middle space="between" style={styles.rows}>
            <Text size={14}>{item.title}</Text>
            <Switch
              onValueChange={() => toggleSwitch(item.id)}
              ios_backgroundColor={materialTheme.COLORS.SWITCH_OFF}
              thumbColor={
                Platform.OS === "android"
                  ? materialTheme.COLORS.SWITCH_OFF
                  : null
              }
              trackColor={{
                false: materialTheme.COLORS.SWITCH_OFF,
                true: materialTheme.COLORS.SWITCH_ON,
              }}
              value={switchStates[item.id] || false} // 스위치 상태를 사용
            />
          </Block>
        );
      case "button":
        return (
          <Block style={styles.rows}>
            <TouchableOpacity onPress={() => navigate("Pro")}>
              <Block row middle space="between" style={{ paddingTop: 7 }}>
                <Text size={14}>{item.title}</Text>
                <Icon
                  name="angle-right"
                  family="font-awesome"
                  style={{ paddingRight: 5 }}
                />
              </Block>
            </TouchableOpacity>
          </Block>
        );
      default:
        break;
    }
  };

  const recommended = [
    { title: "Use FaceID to sign in", id: "face", type: "switch" },
    { title: "Auto-Lock security", id: "autolock", type: "switch" },
    { title: "Notifications", id: "Notifications", type: "button" },
  ];

  const payment = [
    { title: "Manage Payment Options", id: "Payment", type: "button" },
    { title: "Manage Gift Cards", id: "gift", type: "button" },
  ];

  const privacy = [
    { title: "User Agreement", id: "Agreement", type: "button" },
    { title: "Privacy", id: "Privacy", type: "button" },
    { title: "About", id: "About", type: "button" },
  ];

  return (
    <View
      showsVerticalScrollIndicator={false}
      contentContainerStyle={styles.settings}
    >
      <FlatList
        data={recommended}
        keyExtractor={(item, index) => item.id}
        renderItem={renderItem}
        ListHeaderComponent={
          <Block style={styles.title}>
            <Text
              bold
              center
              size={theme.SIZES.BASE}
              style={{ paddingBottom: 5 }}
            >
              Recommended Settings
            </Text>
            <Text center muted size={12}>
              These are the most important settings
            </Text>
          </Block>
        }
      />
      <Block style={styles.title}>
        <Text bold center size={theme.SIZES.BASE} style={{ paddingBottom: 5 }}>
          Payment Settings
        </Text>
        <Text center muted size={12}>
          These are also important settings
        </Text>
      </Block>
      <FlatList
        data={payment}
        keyExtractor={(item, index) => item.id}
        renderItem={renderItem}
      />
      <Block style={styles.title}>
        <Text bold center size={theme.SIZES.BASE} style={{ paddingBottom: 5 }}>
          Privacy Settings
        </Text>
        <Text center muted size={12}>
          Third most important settings
        </Text>
      </Block>
      <FlatList
        data={privacy}
        keyExtractor={(item, index) => item.id}
        renderItem={renderItem}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  settings: {
    paddingVertical: theme.SIZES.BASE / 3,
  },
  title: {
    paddingTop: theme.SIZES.BASE,
    paddingBottom: theme.SIZES.BASE / 2,
  },
  rows: {
    height: theme.SIZES.BASE * 2,
    paddingHorizontal: theme.SIZES.BASE,
    marginBottom: theme.SIZES.BASE / 2,
  },
});
