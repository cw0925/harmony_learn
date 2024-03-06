import AxiosHttpRequest from './AxiosHttp'
import { AxiosError, AxiosRequestHeaders } from '@ohos/axios';
import { LogUtil } from '../../utils/LogUtil';
import { JsonUtil } from '../../utils/JsonUtil';
import { StorageUtil } from '../../utils/StorageUtil';
import { StorageKeys } from '../../common/constants/StorageKeys';
import { Router } from '../../route/Router';
import { RoutePath } from '../../route/RoutePath';
import { hideLoadingDialog } from '../../utils/DialogUtil';
import showToast from '../../utils/ToastUtil';
import { ApiList } from './ApiList';

/**
 * axios请求客户端创建
 */
const axiosClient = new AxiosHttpRequest({
  baseURL: ApiList.baseUrl,
  timeout: 10 * 1000,
  checkResultCode: false,
  headers: {
    'Content-Type': 'application/json'
  } as AxiosRequestHeaders,
  proxy:{
    host: '192.168.1.252',
    port: 7035,
  },
  interceptorHooks: {
    requestInterceptor: async (config) => {
      // 在发送请求之前做一些处理，例如打印请求信息
      LogUtil.debug('网络请求Request 请求方法:', `${config.method}`);
      LogUtil.debug('网络请求Request 请求链接:', `${config.url}`);
      LogUtil.debug('网络请求Request Params:', `\n${JsonUtil.stringify(config.params)}`);
      LogUtil.debug('网络请求Request Data:', `${JsonUtil.stringify(config.data)}`);
      axiosClient.config.showLoading = config.showLoading
      axiosClient.config.headers.token = 'e43683f9-264d-461e-8e6d-a7e716dfdea9'
      if (config.showLoading) {
        showLoadingDialog("加载中...")
      }
      if (config.checkLoginState) {
        let hasLogin = await StorageUtil.get(StorageKeys.USER_LOGIN, false)
        LogUtil.debug('网络请求Request 登录状态校验>>>', `${hasLogin.toString()}`);
        if (hasLogin) {
          return config
        } else {
          if (config.needJumpToLogin) {
            Router.push(RoutePath.TestPage)
          }
          throw new AxiosError("请登录")
        }
      }
      return config;
    },
    requestInterceptorCatch: (err) => {
      LogUtil.error("网络请求RequestError", err.toString())
      if (axiosClient.config.showLoading) {
        hideLoadingDialog()
      }
      return err;
    },
    responseInterceptor: (response) => {
      //优先执行自己的请求响应拦截器，在执行通用请求request的
      if (axiosClient.config.showLoading) {
        hideLoadingDialog()
      }
      LogUtil.debug('网络请求响应Response:', `\n${JsonUtil.stringify(response.data)}`);
      if (response.status === 200) {
        // @ts-ignore
        const checkResultCode = response.config.checkResultCode
        if (checkResultCode && response.data.errorCode != 0) {
          showToast(response.data.errorMsg)
          return Promise.reject(response)
        }
        return Promise.resolve(response.data);
      } else {
        return Promise.reject(response);
      }
    },
    responseInterceptorCatch: (error) => {
      if (axiosClient.config.showLoading) {
        hideLoadingDialog()
      }
      LogUtil.error("网络请求响应异常", error.toString())
      errorHandler(error);
      return Promise.reject(error);
    },
  }
});

export function errorHandler(error: any) {
  if (error instanceof AxiosError) {
    showToast(error.message)
  } else if (error != undefined && error.response != undefined && error.response.status) {
    switch (error.response.status) {
    // 401: 未登录
    // 未登录则跳转登录页面，并携带当前页面的路径
    // 在登录成功后返回当前页面，这一步需要在登录页操作。
      case 401:

        break;
    // 403 token过期
    // 登录过期对用户进行提示
    // 清除本地token和清空vuex中token对象
    // 跳转登录页面
      case 403:
        showToast("登录过期，请重新登录")
      // 清除token
      // localStorage.removeItem('token');
        break;
    // 404请求不存在
      case 404:
        showToast("网络请求不存在")
        break;

    // 其他错误，直接抛出错误提示
      default:
        showToast(error.response.data.message)
    }

  }
}

export default axiosClient;
function showLoadingDialog(arg0: string) {
  LogUtil.error("网络请求响应异常", 'showLoadingDialog')
  throw new Error('Function not implemented.');
}
