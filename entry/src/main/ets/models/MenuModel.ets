export interface MenuModel {
  list: MenuItem[];
}

export type MenuList = MenuItem[];

export interface MenuItem {
  id: number;
  columnNo: number;
  type: number;
  icon?: string;
  name: string;
  status: number;
  list: MenuItem[];
}