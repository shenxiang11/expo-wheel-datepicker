import { registerWebModule, NativeModule } from 'expo';

import { ExpoWheelDatepickerModuleEvents } from './ExpoWheelDatepicker.types';

class ExpoWheelDatepickerModule extends NativeModule<ExpoWheelDatepickerModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ExpoWheelDatepickerModule, 'ExpoWheelDatepickerModule');
