import router from '@ohos.router'
import { LogUtil } from '../utils/LogUtil';

export class Router {
  static push(url: string, params?: Object) {
    router.pushUrl({ url: url, params: params }, router.RouterMode.Standard, (err) => {
      if (err) {
        LogUtil.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
        return;
      }
      LogUtil.info('pushUrl success' + url);
    })
  }
}