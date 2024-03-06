export class ApiList {

  static readonly baseUrl: string = "http://yzsport.zhicaihuyu.cn"

  static readonly appGateway: string = "/yangzhou-c-rest"

  static readonly getCode: string = ApiList.appGateway + "/common/sendSmsCode"

  static readonly menuList: string = ApiList.appGateway + "/home-column/list"

  static readonly pwdLogin: string = ApiList.appGateway + "/login/loginByPwd"

  static readonly matchList: string = ApiList.appGateway + "/appMatch/selectPageList"

}