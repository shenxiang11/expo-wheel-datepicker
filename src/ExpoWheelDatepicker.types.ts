import type { StyleProp, ViewStyle } from 'react-native';

export type OnDateSelectedPayload = {
  date: string;
};

export type ExpoWheelDatepickerModuleEvents = {
  onChange: (params: ChangeEventPayload) => void;
};

export type ChangeEventPayload = {
  value: string;
};

export type ExpoWheelDatepickerViewProps = {
  onDateChange: (event: { nativeEvent: OnDateSelectedPayload }) => void;
  style?: StyleProp<ViewStyle>;
};
