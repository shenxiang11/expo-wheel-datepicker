import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpoWheelDatepickerViewProps } from './ExpoWheelDatepicker.types';

const NativeView: React.ComponentType<ExpoWheelDatepickerViewProps> =
  requireNativeView('ExpoWheelDatepicker');

export default function ExpoWheelDatepickerView(props: ExpoWheelDatepickerViewProps) {
  return <NativeView {...props} />;
}
