
export interface MenuList {
  data: MenuModel[];
}

export interface MenuModel {
  id: number;
  columnNo: number;
  type: number;
  icon: string;
  name: string;
  status: number;
}