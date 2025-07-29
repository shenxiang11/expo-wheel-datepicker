import * as React from 'react';

import { ExpoWheelDatepickerViewProps } from './ExpoWheelDatepicker.types';

export default function ExpoWheelDatepickerView(props: ExpoWheelDatepickerViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
