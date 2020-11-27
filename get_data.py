#!/usr/bin/python
# -*- coding: UTF-8 -*-


'''
Case Info:
    Name:This is a Case Title
    Pre:
        1.Get fiO performance data
        2.Import data into txt
    TestStep:
        1.Fetching the data
        2.Import data into excel
    Author:levi.zhang
    Topo:Win
'''

import os, re


#创建一个列表存放最终数据
total_list = []

def get_dir_list(path):
    # 获取要读取数据的文件，并将文件目录下的子文件输出到一个列表
    dir_list=[]
    dir_p=os.listdir(path)
    for dir in dir_p:
        dir_path = os.path.join(path, dir)
        dir_list.append(dir_path)
    return dir_list


def get_data(path, dir_name):
    # 首先遍历当前目录所有文件及文件夹
    file_list = os.listdir(path)
    # 准备循环判断每个元素是否是文件夹还是文件，是文件的话，把名称传入list，是文件夹的话，递归
    for file in file_list:
        # 利用os.path.join()方法取得路径全名，并存入file_path变量
        file_path = os.path.join(path, file)
        if os.path.isfile(file_path):
            if re.search(r'vst.*', file_path):
                continue
            elif re.search(r'.*read', file_path):
                read_log(file_path, dir_name)
            elif re.match(r'.*write', file):
                write_log(file_path, dir_name)
            else:
                rand_rw_read(file_path, dir_name)
                rand_rw_write(file_path, dir_name)



def read_log(file, dir_name):
    # 获取fio的read性能
    data_list = []
    with open(file, 'r')as f:
        for line in f.readlines():
            if re.search(r'\s+read', line):
                data = re.search(r'\((\d+.*)\)\(', line)
                read = data.group(1)
                file_name = os.path.basename(file)
                data_list.append(dir_name + '--' + file_name + '~~~~read:')
                data_list.append(read)
                total_list.append(data_list)



def write_log(file, dir_name):
    # 获取fio的write性能
    data_list = []
    with open(file, 'r')as f:
        for line in f.readlines():
            if re.search(r'\s+write', line):
                data = re.search(r'\((\d+.*)\)\(', line)
                read = data.group(1)
                file_name = os.path.basename(file)
                data_list.append(dir_name + '--' + file_name + '~~~~write:')
                data_list.append(read)
                total_list.append(data_list)


def rand_rw_read(file, dir_name):
    # 获取fio的rw性能
    data_list = []
    with open(file, 'r')as f:
        for line in f.readlines():
            if re.search(r'\s+read', line):
                data = re.search(r'\((\d+.*)\)\(', line)
                read = data.group(1)
                file_name = os.path.basename(file)
                data_list.append(dir_name + '--' + file_name + '~~~~read:')
                data_list.append(read)
                total_list.append(data_list)

def rand_rw_write(file, dir_name):
    # 获取fio的rw性能
    data_list = []
    with open(file, 'r')as f:
        for line in f.readlines():
            if re.search(r'\s+write', line):
                data = re.search(r'\((\d+.*)\)\(', line)
                write = data.group(1)
                file_name = os.path.basename(file)
                data_list.append(dir_name + '--' + file_name + '~~~~write:')
                data_list.append(write)
                total_list.append(data_list)


def output_txt(list):
    # 输出数据到TXT
    output = open('data.txt', 'w', encoding='gbk')
    output.write('fio_name                                                                                                speed\n')
    output.write('\n')

    for row in list:
            rowtxt = '{}            {}'.format(row[0], row[1])
            output.write(rowtxt)
            output.write('\n')
    output.close()

def main():
    dir_list=get_dir_list('C:/Users/bwhq-rd-1783/Desktop/58H_SSV4_fio')
    for dir in dir_list:
        dir_name = os.path.basename(dir)
        dir_name = dir_name.split('.')[0]
        get_data(dir, dir_name)
    output_txt(total_list)




if __name__ == '__main__':
    # dir_list = ['C:/Users/bwhq-rd-1783/Desktop/58H_SSV4_fio/58H+SSV4+128GB+m2',
    #             'C:/Users/bwhq-rd-1783/Desktop/58H_SSV4_fio/58H+SSV4+128GB+mSATA',
    #             'C:/Users/bwhq-rd-1783/Desktop/58H_SSV4_fio/58H+SSV4+256GB+m2',
    #             'C:/Users/bwhq-rd-1783/Desktop/58H_SSV4_fio/58H+SSV4+256GB+mSATA',
    #             ]
    try:
        main()
    except  Exception:
        raise('Test Raise')