// 3、创建HttpManager.ets核心类
import { RequestOptions } from './RequestOptions';
import { httpCore as HttpCore } from './HttpCore';
/**
 * <pre>
 * @desc       : 对外管理器
 * </pre>
 */
export class HttpManager {
  private static mInstance: HttpManager;

  // 防止实例化
  private constructor() {
  }

  static getInstance(): HttpManager {
    if (!HttpManager.mInstance) {
      HttpManager.mInstance = new HttpManager();
    }
    return HttpManager.mInstance;
  }

  request<T>(option: RequestOptions): Promise<T> {
    return HttpCore.request(option);
  }
}

///使用示例
// 6、页面中使用示例
// handleClick() {
//   HttpManager.getInstance()
//     .request<TestBean>({
//       method: RequestMethod.GET,
//       url: 'https://jsonplaceholder.typicode.com/todos/1' //公开的API
//     })
//     .then((result) => {
//       console.info(JSON.stringify(result));
//     })
//     .catch((err) => {
//       console.error(JSON.stringify(err));
//     });
// }

// 7、TestBean.ets
/**
 * <pre>
 * @desc       : 测试Bean
 * </pre>
 */
// export interface TestBean {
//
//   /**
//    * {
//    "userId": 1,
//    "id": 1,
//    "title": "delectus aut autem",
//    "completed": false
//    }
//    */
//
//   userId: number,
//   id: number,
//   title: string,
//   completed: boolean
//
// }