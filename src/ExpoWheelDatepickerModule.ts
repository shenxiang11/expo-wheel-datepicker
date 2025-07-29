import { NativeModule, requireNativeModule } from 'expo';

import { ExpoWheelDatepickerModuleEvents } from './ExpoWheelDatepicker.types';

declare class ExpoWheelDatepickerModule extends NativeModule<ExpoWheelDatepickerModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoWheelDatepickerModule>('ExpoWheelDatepicker');
