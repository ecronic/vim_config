## Features
	1. �������/�˵�����
	2. ������״̬����Ĭ�����ع������Ͳ˵�����F2��ݼ��ɴ�
	3. ��ݼ���Ctrl+]ִ��ctags��ת��Ctrl+T���أ�F12��ݼ��Զ�����/����tags�ļ�,��ͨģʽ��wm��VIM����wmmanager����
	4. �Զ���ȫ([{������
	5. �Զ�Ϊ.c.h�Ȳ����ļ�ͷע��
	6. F3��ݼ��Զ����뺯��ע��
	7. ������������Ϊ��Բ��Ӣ������ΪCourier New
	8. �﷨����
	9. omnicppcompleteʵ���Զ�C/C++���벹ȫ
	10. ��ǰ�и���
	11. ʹ��molokai����TextMate����
	12. ʹ��vim-markdown���ʵ��Markdown�﷨������
	13. Visualģʽ��ѡ��ע�ʹ���� \ccע�� \co��ע��
	14. Visualģʽ��ѡ���ַ�����ʹ��#,*,gv��ݼ��ɿ���ʵ���ĵ��ڶ�ѡ���ַ����Ĳ���
	15. ���NERDTree�������NERDTree���ɵ�winmanager������
	16. ���code_complete�������ʹ��ȫ�ڲ���ģʽ��+TAB��ݼ���ɣ��书�ܰ�����
	
		- ����ģʽ��cc+TAB�����/**/��ʽ��ע��
		- ����ģʽ��cd+TAB�����/**< */doxgen��ʽ��ע��
		- ����ģʽ��ff+TAB��ͷ�ļ������#ifdef #define #endif��ֹ�ظ�������Ԥ�������
		- ����ģʽ��is+TAB������ϵͳͷ�ļ�
		- ����ģʽ��in+TAB�������Զ���ͷ�ļ�
		- main������if/for/switch/while�������Զ���ȫ���������ź�TAB�ܽ��к���������ʾ

	17. ״̬����ʾechofunc������ʾ�����ڶ��ͬ������tagʱ�����뺯�������ź�ʹ��Ctrl+u/d��ݼ��л�		  
	18. �������С����

## Plugins
    echofunc           ����������ʾ
    taglist            ��ǩ
    winmanager         ���ڹ��� ��ݼ�wm
    bufexplore         ���ļ��༭������� ��ݼ�\be \bs \bv
    omnicppcomplete    C/C++�����Զ���ʾ
    colors/*           ����VIM����
    vim-markdown       Markdown�﷨���� https://github.com/plasticboy/vim-markdown
    NERDTree           �ļ������������
    a.vim              .h��.c�ļ��л������ͨ��:A�����л�
    code_complete.vim  ���벹ȫ���ܣ����������Զ���ʾ�о������ã���ȻechofuncҲ�ṩ�˺���������ʾ

## Key Mapping
    F2                 �򿪹������Ͳ˵���
    Ctrl+]             Ctags��ת 
    Ctrl+T             Ctags����
    F12                ���������tags�ļ�
    wm                 ��winmanager��ർ������
    F3                 ���뺯��ע��
    \cc                ע�ʹ����
    \co                ��ע�ʹ����
    #,*                Visualģʽ�¶�ѡ���ַ�����
    NERDTree/o��i      ��NERDTree�д�ѡ���ļ�
    Ctrl+u/d           EchoFunc��״̬���ж������tagʱ���л�tag

## exec
    ctags.exe          Windows�����µ�ctags,���õ�gvim.exe����Ŀ¼,��ɵ�http://ctags.sourceforge.net/����Linux������Ĭ���Ѱ�װ


## User Guide

### Linux(CentOS)

1.	Copy `vimfiles` directory to your home directory. Then mv directory name to `.vim` 

	```
	su root
	mv vimfiles .vim 
	cp .vim /home/monkeyzx/
	```

2.	Copy `vimrc` to `/etc/vimrc`. 

	```
	su root
	cp vimrc /etc/vimrc
	```

### Windows(GVIM 7.3)

1.	Copy `_vimrc` to GVIM install path.
2.	Copy `vimfiles` to GVIM install path.
3.	Copy ctags.exe to the same path as `gvim.exe` file.

![](./disp.png)

