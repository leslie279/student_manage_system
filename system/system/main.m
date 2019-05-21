//
//  main.m
//  system
//
//  Created by 陈培旺 on 2019/5/21.
//  Copyright © 2019 陈培旺. All rights reserved.
//

#import <Foundation/Foundation.h>

#include<stdio.h>
#include<stdlib.h>
#include<malloc.h>
#include<string.h>
#include<io.h>
#include<conio.h>
//定义的全局变量
int choice5;
int iCount;
char Search[20], Search2[20];
typedef struct student {
    char name[20];      //姓名
    char  num[20];        //学号
    char class1[20];    //班级
    int score[3];        //三门成绩
    struct student *next;
}Student;
//登录信息
struct land
{
    char account[20];
    char password[20];
    struct land *next;
};
void Manger();
void Manger_fun(Student *L);
void Start1();         //开始界面1
void Start2();        //开始界面2
void Manger();        //管理员主界面
void Teacher();        //教师主界面
void Student1();    //学生主界面
void mainmenu();    //主菜单
void xinjian();        //新建账户密码
void xgmm();         //修改密码
void xg(char account[20],char m[20]); //修改密码函数
int tjzs3();        //统计账号密码文本个数
void Manger_fun();   //管理员功能函数
Student *read();      //读取文件，查看是否存在，若存在返回头指针
void Start3();        //格式函数
Student *InsList(Student *L);    //增加新的学生信息
Student *modifystudent(Student *L);  //修改学生信息
Student *findstudent(Student *L);    //查询函数
void printstudent(Student *pa);        //显示函数
void land1();        //选择登录界面
void Teacher_fun(); //教师功能
Student *findstudent2(Student *L);
void printstudent(Student *L);


//格式函数
void Start3()
{
    printf("\t\t\t\t***************************************************\n");
    printf("\t\t\t\t\t\t学生管理系统\n");
    printf("\t\t\t\t***************************************************\n");
    printf("\t\t\t姓名\t\t学号\t\t班级\t\t语文\t数学\t英语\n");
}
//显示函数
void printstudent(Student *pa)
{
    if(!pa) {
        printf("没有查询到该学员的信息，请检查输入.");
    } else {
        printf("查找成功!\n");
        Start3();
        printf("\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",pa->name, pa->num, pa->class1, pa->score[0], pa->score[1], pa->score[2]);
    }
    printf("按任意键继续!\n");
    getch();
}
//增加账号及密码
void append() {
    char choice[20];
    system("cls");
    FILE *fp;
    int i = 0, j, flag;
    char ch;
    char mima[20], mima2[20];
    char account[20], temp2[20];
    char password[20], password1[20];
    if ((fp = fopen("land.txt","r"))==NULL) {
        printf("文件不存在或打开错误!");
        exit(1);
    }
    fp = fopen("land.txt","a+");
    while(1) {
        do {
            flag = 1;
            printf("请输入账号: \n");
            scanf("%s",temp2);
            for (j = 0; j < strlen(temp2); j++) {
                if (temp2[j] >= 'A' && temp2[j] <= 'z' || strlen(temp2) != 8) {
                    printf("输入错误，账号只能为8位且不能包含字母\n");
                    flag = 0;
                    break;
                }
            }
        } while (flag == 0);
        strcpy(account, temp2);
        printf("请输入密码: \n");
        while ((ch = getch()) != 13) {
            if (ch == '\b') {
                i--;
                printf("\b");
                printf(" ");
                printf("\b");
            }
            else if(ch != 13){
                mima[i++] = ch;
                printf("*");
            } else {
                break;
            }
        }
        mima[i] = '\0';
        strcpy(password, mima);
        printf("再次输入密码:\n");
        i = 0;
        while ((ch = getch()) != 13) {
            if (ch == '\b') {
                i--;
                printf("\b");
                printf(" ");
                printf("\b");
            }
            else if(ch != 13){
                mima2[i++] = ch;
                printf("*");
            } else {
                break;
            }
        }
        mima2[i] = '\0';
        strcpy(password1, mima2);
        if(strcmp(password,password1) == 0) {
            fprintf(fp,"%s %s\n",account, password);
            break;
        } else {
            printf("两次输入密码不一致，请重新注册:");
            system("cls");
        }
    }
    fclose(fp);
    printf("添加成功，按任意键返回");
    getch();
    system("cls");
}
void kaobei() {
    FILE *fp, *fp1;
    char a[100];
    fp = fopen("linshi.txt", "r+");
    fp1 = fopen("land.txt", "w+");
    while (fgets(a, 30, fp)) {
        fputs(a, fp1);
    }
    fclose(fp);
    fclose(fp1);
    getchar();
    getchar();
}
//删除账号及密码
void Dele() {
    FILE *fp, *fp1;
    char a[100];
    char account[20], temp2[20];
    int flag, j;
    do {
        flag = 1;
        printf("请输入要删除的账号: \n");
        scanf("%s",temp2);
        for (j = 0; j < strlen(temp2); j++) {
            if (temp2[j] >= 'A' && temp2[j] <= 'z' || strlen(temp2) != 8) {
                printf("输入错误，账号只能为8位且不能包含字母\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(account, temp2);
    fp = fopen("land.txt", "r+");
    fp1 = fopen("linshi.txt", "w+");
    while (fgets(a, 30, fp)) {
        if (strncmp(a, account, 8) != 0) {
            fputs(a, fp1);
        }
    }
    printf("删除成功!");
    fclose(fp);
    fclose(fp1);
    kaobei();
}
//查找函数
void chazhao3() {
    char ch;
    FILE *fp;
    fp = fopen("查询.txt","rt");
    if (fp == NULL) {
        printf("文件打开失败,查询.txt可能不存在\n");
        exit(1);
    }
    printf("查询结果如下: \n");
    printf("账号\t密码\n");
    while((ch = fgetc(fp)) != EOF)
        printf("%c",ch);
    fclose(fp);
    printf("按任意键继续!");
    getch();
    system("cls");
}
void zuhe(Student *L){
    char choice[20];
    Student *pa = L->next;
    int flag;
    printf("1.语文和数学均不低于60分的学生\n");
    printf("2.数学和英语均不低于60分的学生\n");
    printf("3.英语和语文均不低于60分的学生\n");
    printf("4.各科均大于60分的学生\n");
    do {
        flag = 1;
        scanf("%s",choice);
        Start3();
        if (strcmp(choice, "1") == 0) {
            while (pa) {
                if (pa->score[0] >= 60 && pa->score[1] >= 60) {
                    printf("\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",pa->name, pa->num, pa->class1, pa->score[0], pa->score[1], pa->score[2]);
                    pa = pa->next;
                } else {
                    pa = pa->next;
                }
            }
        } else if (strcmp(choice, "2") == 0) {
            while (pa) {
                if (pa->score[2] >= 60 && pa->score[1] >= 60) {
                    printf("\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",pa->name, pa->num, pa->class1, pa->score[0], pa->score[1], pa->score[2]);
                    pa = pa->next;
                } else {
                    pa = pa->next;
                }
            }
        } else if (strcmp(choice, "3") == 0) {
            while (pa) {
                if (pa->score[0] >= 60 && pa->score[2] >= 60) {
                    printf("\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",pa->name, pa->num, pa->class1, pa->score[0], pa->score[1], pa->score[2]);
                    pa = pa->next;
                } else {
                    pa = pa->next;
                }
            }
        } else if (strcmp(choice, "4") == 0) {
            while (pa) {
                if (pa->score[0] >= 60 && pa->score[1] >= 60 && pa->score[2] >= 60) {
                    printf("\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",pa->name, pa->num, pa->class1, pa->score[0], pa->score[1], pa->score[2]);
                    pa = pa->next;
                } else {
                    pa = pa->next;
                }
            }
        } else {
            flag = 0;
            printf("输入错误，请检查,按任意键返回\n");
            getch();
            system("cls");
            zuhe(L);
        }
    } while(flag == 0);
    printf("按任意键返回!");
    getch();
}
void find(Student *L) {
    char choice[20];
    int flag;
    printf("1.简单查询\n");
    printf("2.组合查询\n");
    do {
        flag = 1;
        scanf("%s",choice);
        if (strcmp(choice, "1") == 0) {
            L = findstudent2(L);
            printstudent(L);
        } else if (strcmp(choice, "2") == 0) {
            zuhe(L);
        } else {
            flag = 0;
            printf("输入错误，请检查,按任意键返回\n");
            getch();
            system("cls");
            find(L);
        }
    } while(flag == 0);
}
//查找账号及密码
void chazhao2() {
    FILE *fp, *fp1;
    char a[30];
    char account[20], temp2[20];
    int flag, j;
    do {
        flag = 1;
        printf("请输入你想要查询的账号: \n");
        scanf("%s",temp2);
        for (j = 0; j < strlen(temp2); j++) {
            if (temp2[j] >= 'A' && temp2[j] <= 'z' || strlen(temp2) != 8) {
                printf("输入错误，账号只能为8位且不能包含字母,请重新输入\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(account, temp2);
    fp = fopen("land.txt","r+");
    fp1 = fopen("查询.txt","w+");
    if (fp == NULL) {
        printf("文件打开出现错误!");
        exit(1);
    }
    while(fgets(a, 30, fp)) {
        if (strncmp(a, account, 8) == 0) {
            fputs(a, fp1);
            break;
        }
    }
    fclose(fp);
    fclose(fp1);
    chazhao3();
}
//删除学生信息
Student *deletestudent(Student *L) {
    char num1[20];
    char temp[20];
    Student *q, *pre, *p;
    int flag, i;
    iCount--;
    do {
        flag = 1;
        printf("请输入要删除学生的学号: \n");
        scanf("%s",temp);
        for (i = 0; i < strlen(temp); i++) {
            if (temp[i] >= 'A' && temp[i] <= 'z' || strlen(temp) != 5) {
                printf("输入错误，学号只能为5位且不得包含字母，请重新输入!\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(num1, temp);
    p = L->next;
    pre = L;
    while (strcmp(p->num, num1) != 0) {
        pre = pre->next;
        p = p->next;
        if (p == NULL) {
            printf("未查找到该学生信息，请检查输入!\n");
            break;
        }
    }
    if (p != NULL) {
        pre->next = p->next;
        printf("删除成功！\n");
    }
    free(p);
    printf("按任意键返回!\n");
    getch();
    return L;
}
//查询函数
Student *findstudent(Student *L) {
    char num1[20], temp[20];
    int flag, i;
    Student *p = L->next;
    strcpy(num1, Search);
    while (p && strcmp(p->num , num1) != 0) {
        p=p->next;
    }
    return p;
}
Student *findstudent2(Student *L) {
    char num1[20];
    Student *p = L->next;
    printf("请输入要查询的学生学号: \n");
    scanf("%s",num1);
    while (p && strcmp(p->num , num1) != 0) {
        p=p->next;
    }
    return p;
}
//输出全部成绩
void printAll(Student *L) {
    Student *pa = L->next;
    if (pa) {
        Start3();
    }
    while (pa) {
        printf("\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",pa->name, pa->num, pa->class1, pa->score[0], pa->score[1], pa->score[2]);
        pa = pa->next;
    }
    printf("按回车键继续!");
    getchar();
    getchar();
}
//修改学生信息
Student *modifystudent(Student *L) {
    Student *pa = L->next;
    int count = 1;
    char num1[20], temp[20], temp1[20], temp2[20];
    int flag, flag2, Chinese, Math, English;
    int i;
    do {
        flag = 1;
        printf("请输入要修改的学员的学号: \n");
        scanf("%s",temp);
        for (i = 0; i < strlen(temp); i++) {
            if (temp[i] >= 'A' && temp[i] <= 'z' || strlen(temp) != 5) {
                printf("输入错误，学号只能为5位且不得包含字母，请重新输入!\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(num1, temp);
    while (strcmp(pa->num, num1) != 0) {
        pa = pa->next;
        count++;
        if (count == 31) {
            pa = NULL;
            break;
        }
    }
    if (pa != NULL) {
        printf("\t该学生的信息如下: \n");
        printstudent(pa);
        printf("\t------------------------------------------\n");
        printf("\t       *****修改学生信息*****             \n");
        printf("\t------------------------------------------\n");
        do {
            flag = 1;
            printf("重新输入学生的姓名: \n");
            scanf("%s",temp1);
            for (i = 0; i < strlen(temp1); i++) {
                if (temp1[i] >= '0' && temp1[i] <= '9') {
                    printf("姓名不得包含数字，请重新输入!\n");
                    flag = 0;
                    break;
                }
            }
        } while (flag == 0);
        strcpy(pa->name, temp1);
        do {
            flag = 1;
            printf("重新输入学生的学号: \n");
            scanf("%s",temp2);
            for (i = 0; i < strlen(temp2); i++) {
                if (temp2[i] >= 'A' && temp2[i] <= 'z' || strlen(temp2) != 5) {
                    printf("输入错误，学号只能为5位且不得包含字母，请重新输入!\n");
                    flag = 0;
                    break;
                }
            }
        } while (flag == 0);
        strcpy(pa->num, temp2);
        printf("重新输入学生的班级: \n");
        scanf("%s",pa->class1);
        
        printf("请重新输入学生的三门成绩:\n");
        do {
            flag2 = 1;
            Chinese = 0;
            printf("请输入语文成绩: \n");
            scanf("%d",&Chinese);
            if (Chinese < 0 || Chinese > 100) {
                printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
                flag2 = 0;
            }
        } while(flag2 == 0);
        pa->score[0] = Chinese;
        do {
            flag2 = 1;
            printf("请输入数学成绩: \n");
            scanf("%d",&Math);
            if (Math < 0 || Math > 100) {
                printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
                flag2 = 0;
            }
        } while(flag2 == 0);
        pa->score[1] = Math;
        Math = 0;
        do {
            flag2 = 1;
            printf("请输入英语成绩: \n");
            scanf("%d",&English);
            if (English < 0 || English > 100) {
                printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
                flag2 = 0;
            }
        } while(flag2 == 0);
        pa->score[2] = English;
        English = 0;
        printf("修改成功!");
    } else if (pa == NULL) {
        printf("未查询到该学生的信息,请检查输入.按任意键返回\n");
        getch();
        system("cls");
        modifystudent(L);
    }
    printf("\n按任意键返回\n");
    getch();
    return L;
}
//添加新的学生信息
Student *InsList(Student *L) {
    Student *pNew;
    char temp1[20], temp2[20];
    int Chinese, Math, English;
    int i, flag, j;
    iCount++;
    pNew = (Student*)malloc(sizeof(Student));
    printf("请输入要添加的学生的信息: \n");
    do {
        flag = 1;
        printf("请输入学生的姓名: \n");
        scanf("%s",temp1);
        for (j = 0; j < strlen(temp1); j++) {
            if (temp1[j] >= '0' && temp1[j] <= '9') {
                printf("姓名不得包含数字，请重新输入!\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(pNew->name, temp1);
    do {
        flag = 1;
        printf("请输入学生的学号: \n");
        scanf("%s",temp2);
        for (j = 0; j < strlen(temp2); j++) {
            if (temp2[j] >= 'A' && temp2[j] <= 'z' || strlen(temp2) != 5) {
                printf("输入错误，学号只能为5位且不得包含字母，请重新输入!\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(pNew->num, temp2);
    printf("请输入学生的班级: \n");
    scanf("%s",pNew->class1);
    printf("请输入学生的三门成绩: \n");
    do {
        flag = 1;
        printf("请输入语文成绩: \n");
        scanf("%d",&Chinese);
        if (Chinese < 0 || Chinese > 100) {
            printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
            flag = 0;
        }
    } while(flag == 0);
    pNew->score[0] = Chinese;
    do {
        flag = 1;
        printf("请输入数学成绩: \n");
        scanf("%d",&Math);
        if (Math < 0 || Math > 100) {
            printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
            flag = 0;
        }
    } while(flag == 0);
    pNew->score[1] = Math;
    do {
        flag = 1;
        printf("请输入英语成绩: \n");
        scanf("%d",&English);
        if (English < 0 || English > 100) {
            printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
            flag = 0;
        }
    } while(flag == 0);
    pNew->score[2] = English;
    pNew->next = L->next;//关键代码
    L->next = pNew;//关键代码
    printf("添加成功!\n");
    printf("\n按任意键返回!\n");
    getch();
    return L;
}
//读取文件，查看是否存在，若存在返回头指针
Student *read() {
    Student *head, *r, *ptemp;
    FILE *fp;
    fp = fopen("student.txt","rt");
    if (fp == NULL) {
        printf("文件读取失败!");
        exit(1);
    }
    fscanf(fp,"\t\t\t\t***************************************************\n");
    fscanf(fp,"\t\t\t\t\t学生管理系统\n");
    fscanf(fp,"\t\t\t\t***************************************************\n");
    fscanf(fp,"\t\t\t姓名\t\t学号\t\t班级\t\t语文\t数学\t英语\n");
    head = (Student *)malloc(sizeof(Student));
    head->next = NULL;
    r = head;
    while (!feof(fp)) {
        ptemp=(Student *)malloc(sizeof(Student));
        fscanf(fp,"\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",ptemp->name,ptemp->num,ptemp->class1,&ptemp->score[0],&ptemp->score[1],&ptemp->score[2]);
        r->next = ptemp;
        r = ptemp;
        iCount++;
    }
    r->next = NULL;
    fclose(fp);
    return head;
}
void chaxun2(Student *L) {
    char class2[20];
    int choice;
    Student *pa;
    pa = L->next;
    printf("1.网络1班\n2.网络2班\n3.网络3班\n4.网络4班\n5.网络5班\n6.全部班级\n");
    printf("请输入你要查询的班级对应的序号: \n");
    scanf("%d",&choice);
    if (choice == 1) {
        strcpy(class2,"网络1班");
    } else if(choice == 2) {
        strcpy(class2,"网络2班");
    } else if(choice == 3) {
        strcpy(class2,"网络3班");
    }else if(choice == 4) {
        strcpy(class2,"网络4班");
    }else if(choice == 5) {
        strcpy(class2,"网络5班");
    }else if(choice == 6) {
        strcpy(class2,"全部");
    }
    if (strcmp(class2, "网络1班") != 0 &&
        strcmp(class2, "网络2班") != 0 &&
        strcmp(class2, "网络3班") != 0 &&
        strcmp(class2, "网络4班") != 0 &&
        strcmp(class2, "网络5班") != 0 &&
        strcmp(class2, "全部") != 0 ) {
        printf("输入的班级不存在，请重试!\n");
        chaxun2(L);
    }
    if (strcmp(class2, "全部") == 0) {
        printAll(L);
    } else {
        Start3();
        while (pa) {
            if (strcmp(pa->class1, class2) == 0) {
                printf("\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",pa->name, pa->num, pa->class1, pa->score[0], pa->score[1], pa->score[2]);
            }
            pa = pa->next;
        }
        printf("按任意键返回!");
        getch();
    }
}
//查询本班成绩
void chaxun(Student *L) {
    char class2[20];
    Student *pa;
    pa = L->next;
    strcpy(class2, Search2);
    Start3();
    while (pa) {
        if (strcmp(pa->class1, class2) == 0) {
            printf("\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",pa->name, pa->num, pa->class1, pa->score[0], pa->score[1], pa->score[2]);
        }
        pa = pa->next;
    }
    printf("按任意键返回!");
    getch();
}
void File(Student *L) {
    FILE *fp;
    int i;
    Student *pa = L->next;
    fp = fopen("student.txt","wt+");
    if (fp == NULL) {
        printf("文件不存在或打开错误");
        exit(1);
    }
    fprintf(fp,"\t\t\t\t***************************************************\n");
    fprintf(fp,"\t\t\t\t\t学生管理系统\n");
    fprintf(fp,"\t\t\t\t***************************************************\n");
    fprintf(fp,"\t\t\t姓名\t\t学号\t\t班级\t\t语文\t数学\t英语\n");
    for (i = 0; i < iCount; i++) {
        fprintf(fp,"\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",pa->name, pa->num, pa->class1, pa->score[0], pa->score[1], pa -> score[2]);
        pa = pa->next;
    }
    printf("文件录入成功!");
    printf("\n【注】:当前录入了%d个学生的信息,按任意键退出\n",iCount);
    getch();
    system("cls");
    fclose(fp);
}
void File5(Student *L) {
    FILE *fp;
    int i;
    Student *pa = L->next;
    fp = fopen("student.txt","wt+");
    if (fp == NULL) {
        printf("文件不存在或打开错误");
        exit(1);
    }
    fprintf(fp,"\t\t\t\t***************************************************\n");
    fprintf(fp,"\t\t\t\t\t学生管理系统\n");
    fprintf(fp,"\t\t\t\t***************************************************\n");
    fprintf(fp,"\t\t\t姓名\t\t学号\t\t班级\t\t语文\t数学\t英语\n");
    while (pa) {
        fprintf(fp,"\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",pa->name, pa->num, pa->class1, pa->score[0], pa->score[1], pa -> score[2]);
        pa = pa->next;
    }
    printf("下载成功!\n按任意键退出");
    //printf("\n【注】:当前录入了%d个学生的信息,按任意键退出\n",iCount);
    getch();
    system("cls");
    fclose(fp);
}
void File4(Student *L) {
    FILE *fp;
    int i;
    Student *pa = L->next;
    fp = fopen("student.txt","wt+");
    if (fp == NULL) {
        printf("文件不存在或打开错误");
        exit(1);
    }
    fprintf(fp,"\t\t\t\t***************************************************\n");
    fprintf(fp,"\t\t\t\t\t学生管理系统\n");
    fprintf(fp,"\t\t\t\t***************************************************\n");
    fprintf(fp,"\t\t\t姓名\t\t学号\t\t班级\t\t语文\t数学\t英语\n");
    while (pa) {
        fprintf(fp,"\t\t\t%s\t\t%s\t\t%s\t\t%d\t%d\t%d\n",pa->name, pa->num, pa->class1, pa->score[0], pa->score[1], pa -> score[2]);
        pa = pa->next;
    }
    fclose(fp);
}
//数据读写1——学生信息
void File2() {
    FILE *fp;
    char filename[100];
    char ch;
    fp = fopen("student.txt","rt");
    if (fp == NULL) {
        printf("文件打开失败,student.txt可能不存在\n");
        exit(1);
    }
    printf("所有学生信息如下: \n");
    while((ch = fgetc(fp)) != EOF)
        printf("%c",ch);
    fclose(fp);
    printf("\n");
}
//数据读写2——账号密码
void File3() {
    FILE *fp, *fp2;
    char filename[100];
    char ch;
    fp = fopen("land.txt","rt");
    fp2 = fopen("teacher.txt","rt");
    if (fp == NULL) {
        printf("文件打开失败,land.txt可能不存在\n");
        exit(1);
    }
    if (fp2 == NULL) {
        printf("文件打开失败,land.txt可能不存在\n");
        exit(1);
    }
    printf("当前学生存在的账号及密码如下:\n");
    while((ch = fgetc(fp)) != EOF)
        printf("%c",ch);
    printf("当前教师存在的账号及密码如下:\n");
    while((ch = fgetc(fp2)) != EOF)
        printf("%c",ch);
    fclose(fp);
    fclose(fp2);
    printf("\n");
    printf("按任意键返回!");
    getch();
}
//输出函数
void Output(Student *L) {
    Student *pa;
    Start3();
    pa = L->next;
    while(pa) {
        printf("\t\t\t%s\t\t",pa->name);
        printf("%s\t\t",pa->num);
        printf("%s\t\t",pa->class1);
        printf("%d\t%d\t%d\n",pa->score[0], pa->score[1], pa->score[2]);
        pa = pa->next;
    }
}
//创建链表,将学生信息输入
Student *Create() {
    int choice;
    int i, flag2, Chinese, Math, English;
    char num1[20], temp[20], temp1[20], temp2[20];
    int flag;
    int j;
    Student *L, *pNew, *r;
    L = (Student*)malloc(sizeof(Student));
    pNew = (Student*)malloc(sizeof(Student));
    L->next = NULL;
    r = L;
    //printf("【注】:输入学生的信息，当姓名输入为'0'时，结束输入!\n");
    printf("现在可以开始输入学生信息了: \n");
    do {
        flag = 1;
        printf("请输入学生的姓名: \n");
        scanf("%s",temp1);
        for (j = 0; j < strlen(temp1); j++) {
            if (temp1[j] >= '0' && temp1[j] <= '9') {
                printf("姓名不得包含数字，请重新输入!\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(pNew->name, temp1);
    fflush(stdin);
    do {
        flag = 1;
        printf("请输入学生的学号: \n");
        scanf("%s",temp);
        for (j = 0; j < strlen(temp); j++) {
            if (temp[j] >= 'A' && temp[j] <= 'z' || strlen(temp) != 5) {
                printf("输入错误，学号只能为5位且不得包含字母，请重新输入!\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(pNew->num, temp);
    fflush(stdin);
    printf("请输入学生的班级:\n");
    scanf("%s",pNew->class1);
    fflush(stdin);
    printf("请输入学生的三门成绩:\n");
    do {
        flag2 = 1;
        Chinese = 0;
        printf("请输入语文成绩: \n");
        scanf("%d",&Chinese);
        if (Chinese < 0 || Chinese > 100) {
            printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
            flag2 = 0;
        }
    } while(flag2 == 0);
    pNew->score[0] = Chinese;
    do {
        flag2 = 1;
        printf("请输入数学成绩: \n");
        scanf("%d",&Math);
        if (Math < 0 || Math > 100) {
            printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
            flag2 = 0;
        }
    } while(flag2 == 0);
    pNew->score[1] = Math;
    Math = 0;
    do {
        flag2 = 1;
        printf("请输入英语成绩: \n");
        scanf("%d",&English);
        if (English < 0 || English > 100) {
            printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
            flag2 = 0;
        }
    } while(flag2 == 0);
    pNew->score[2] = English;
    English = 0;
    fflush(stdin);
    iCount++;
    do {
        flag = 1;
        printf("继续创建请按1，结束创建请按2!\n");
        scanf("%d",&choice);
        if (choice == 1) {
            ;
        } else if(choice == 2) {
            r->next = pNew;
            pNew->next = NULL;
            return L;
        } else {
            printf("输入错误，请重新输入, \n");
            flag = 0;
        }
    }while(flag == 0);
    while (1) {
        iCount++;
        r->next = pNew;
        r = pNew;
        pNew=(Student*)malloc(sizeof(Student));
        memset(temp1, 0, sizeof(char) * 20);
        do {
            flag = 1;
            printf("请输入学生的姓名: \n");
            scanf("%s",temp1);
            for (j = 0; j < strlen(temp1); j++) {
                if (temp1[j] >= '0' && temp1[j] <= '9') {
                    printf("姓名不得包含数字，请重新输入!\n");
                    flag = 0;
                    break;
                }
            }
        } while (flag == 0);
        strcpy(pNew->name, temp1);
        fflush(stdin);
        memset(temp, 0, sizeof(char) * 20);
        do {
            flag = 1;
            printf("请输入学生的学号: \n");
            scanf("%s",temp);
            for (j = 0; j < strlen(temp); j++) {
                if (temp[j] >= 'A' && temp[j] <= 'z' || strlen(temp) != 5) {
                    printf("输入错误，学号只能为5位且不得包含字母，请重新输入!\n");
                    flag = 0;
                    break;
                }
            }
        } while (flag == 0);
        strcpy(pNew->num, temp);
        fflush(stdin);
        printf("请输入学生的班级:\n");
        scanf("%s",pNew->class1);
        fflush(stdin);
        printf("请输入学生的三门成绩:\n");
        do {
            flag2 = 1;
            printf("请输入语文成绩: \n");
            scanf("%d",&Chinese);
            if (Chinese < 0 || Chinese > 100) {
                printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
                flag2 = 0;
            }
        } while(flag2 == 0);
        pNew->score[0] = Chinese;
        Chinese = 0;
        do {
            flag2 = 1;
            printf("请输入数学成绩: \n");
            scanf("%d",&Math);
            if (Math < 0 || Math > 100) {
                printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
                flag2 = 0;
            }
        } while(flag2 == 0);
        pNew->score[1] = Math;
        Math = 0;
        do {
            flag2 = 1;
            printf("请输入英语成绩: \n");
            scanf("%d",&English);
            if (English < 0 || English > 100) {
                printf("输入错误，成绩只能在0~100之间，请重新输入: \n");
                flag2 = 0;
            }
        } while(flag2 == 0);
        pNew->score[2] = English;
        English = 0;
        fflush(stdin);
        do {
            flag = 1;
            printf("继续创建请按1，结束创建请按2!\n");
            scanf("%d",&choice);
            if (choice == 1) {
                ;
            } else if(choice == 2) {
                r->next = pNew;
                pNew->next = NULL;
                return L;
            } else {
                printf("输入错误！请重新输入");
                flag = 0;
            }
        } while(flag == 0);
    }
    //r->next=NULL;
    //return L;
}
//统计账号密码文本个数
int tjzs3() {
    FILE *fp;
    int n;
    char account[20] = {'\0'};
    char mm[20] = {'\0'};
    fp = fopen("land.txt","r");
    for (n = 0; !feof(fp); n++) {
        fscanf(fp,"%s %s",account, mm);
    }
    n--;
    fclose(fp);//关闭文件
    return n;//返回个数
}
//修改函数
void xg(char account[20], char m[20]) {
    FILE *fp;
    int n = 0, j, k;
    char account1[20];
    char mima1[20];
    struct land *head, *p, *p1, *p2;
    fp = fopen("land.txt","r");
    j = tjzs3();
    for (k = 0;k <= j; k++) {
        fscanf(fp,"%s %s",account1, mima1);
        if (strcmp(account,account1) != 0) {
            n++;
            if (n == 1) {
                p1 = p2 = (struct land*)malloc(sizeof(struct land));
                head = p1;
            } else {
                p2->next = p1;
                p2 = p1;
                p1 = (struct land*)malloc(sizeof(struct land));
            }
            strcpy(p1->account, account1);
            strcpy(p1->password, mima1);
        }
    }
    if (n == 0) {
        head = NULL;
    } else {
        p2->next = p1;
        p1->next = NULL;
        fclose(fp);
    }
    fp = fopen("land.txt","w");
    fclose(fp);
    fp = fopen("land.txt","a");
    p = head;
    for (; p != NULL; ) {
        fprintf(fp,"%s %s%\n",p->account, p->password);
        p = p->next;
    }
    fprintf(fp,"%s %s\n",account, m);
    printf("\n修改成功，按任意键返回!\n");
    getch();
    fclose(fp);
    system("cls");
}
//匹配数据库中的账号密码
int match(char m[20], char a[20]) {
    FILE *fp;
    char account[20];
    char password[20];
    //文件不存在
    if ((fp = fopen("land.txt","r")) == NULL) {
        system ("cls");
        printf("\n还未存在用户!请先注册账号");
        getch();
        system("cls");
        mainmenu();
    }
    for (;!feof(fp); ) {
        fscanf(fp,"%s%s",account,password);
        if ((strcmp(m, account) == 0)) {
            if (strcmp(a,password) == 0) {
                return 1;
            } else {
                return -1;
            }
        }
    }
    return 0;
}
//修改密码
void xgmm() {
    FILE *fp;
    int k = 0, m = 0, n = 0, flag, p;
    char zh[20];
    char chazhao[20], temp2[20];
    char password[20]={'\0'},password1[20]={'\0'};
    char mm[20]={'\0'};
    char i;
    int j = 0;
    char ch;
    char mima[20], mima2[20];
    if ((fp = fopen("land.txt","r")) == NULL) {
        system("cls");
        printf("\n记录文件不存在!按任意键返回");
        getch();
        system("cls");
        mainmenu();
    }
    system("cls");
    do {
        flag = 1;
        printf("请输入你要修改的账号: \n");
        scanf("%s",temp2);
        for (p = 0; p < strlen(temp2); p++) {
            if (temp2[p] >= 'A' && temp2[p] <= 'z' || strlen(temp2) != 8) {
                printf("输入错误，账号只能为8位且不能包含字母\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(chazhao, temp2);
    printf("请输入你的旧密码； \n");
    while ((ch = getch()) != 13) {
        if (ch == '\b') {
            j--;
            printf("\b");
            printf(" ");
            printf("\b");
        }
        else if(ch != 13){
            mima[j++] = ch;
            printf("*");
        } else {
            break;
        }
    }
    mima[j] = '\0';
    strcpy(password, mima);
    m =tjzs3();
    j = 0;
    for (n = 0; n <= m; n++) {
        fscanf(fp,"%s %s",zh, mm);
        if(strcmp(zh,chazhao) == 0) {
            if(!strcmp(mm,password)) {
                printf("\n请输入新的密码: \n");
                while ((ch = getch()) != 13) {
                    if (ch == '\b') {
                        j--;
                        printf("\b");
                        printf(" ");
                        printf("\b");
                    }
                    else if(ch != 13){
                        mima[j++] = ch;
                        printf("*");
                    } else {
                        break;
                    }
                }
                mima[j] = '\0';
                strcpy(password, mima);
                printf("\n再次输入密码:\n");
                j = 0;
                while ((ch = getch()) != 13) {
                    if (ch == '\b') {
                        j--;
                        printf("\b");
                        printf(" ");
                        printf("\b");
                    }
                    else if(ch != 13){
                        mima2[j++] = ch;
                        printf("*");
                    } else {
                        break;
                    }
                }
                mima2[j] = '\0';
                strcpy(password1, mima2);
                if (strcmp(password,password1) == 0) {
                    xg(chazhao,password);
                    mainmenu();
                    system("cls");
                } else {
                    printf("\n两次输入密码不一致,按任意键退出");
                    getch();
                    system("cls");
                    mainmenu();
                }
            } else {
                printf("\n旧密码错误，按任意键返回！\n");
                getch();
                system("cls");
                mainmenu();
            }
        }
    }
    printf("不存在此账号，按任意键返回");
    fclose(fp);
    getch();
    system("cls");
}
//登录函数
void land() {
    char account[20];
    char password[20];
    int i = 2;
    int j = 0, p, flag;
    char ch;
    char mima[20], mima2[20], temp2[20];
    system("cls");
    do {
        flag = 1;
        printf("请输入账号: \n");
        scanf("%s",temp2);
        for (p = 0; p < strlen(temp2); p++) {
            if (temp2[p] >= 'A' && temp2[p] <= 'z' || strlen(temp2) != 8) {
                printf("输入错误，账号只能为8位且不能包含字母\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(account, temp2);
    printf("请输入密码:\n");
    while ((ch = getch()) != 13) {
        if (ch == '\b') {
            j--;
            printf("\b");
            printf(" ");
            printf("\b");
        }
        else if(ch != 13){
            mima[j++] = ch;
            printf("*");
        } else {
            break;
        }
    }
    mima[j] = '\0';
    strcpy(password, mima);
    i = match(account, password);
    if (i == 1) {
        printf("\n登陆成功!按任意键继续");
        getch();
        system("cls");
    } else {
        if (i == -1) {
            printf("密码错误!请重新输入");
            getch();
            land();
        }
        if (i == 0) {
            printf("不存在此用户!请重新输入");
            getch();
            land();
        }
    }
}
//匹配数据库中的账号密码
int match2(char m[20], char a[20]) {
    FILE *fp;
    char account[20];
    char password[20];
    //文件不存在
    if ((fp = fopen("land.txt","r")) == NULL) {
        system ("cls");
        printf("\n还未存在用户!请先注册账号");
        getch();
        system("cls");
        mainmenu();
    }
    for (;!feof(fp); ) {
        fscanf(fp,"%s%s",account,password);
        if ((strcmp(m, account) == 0)) {
            if (strcmp(a,password) == 0) {
                return 1;
            } else {
                return -1;
            }
        }
    }
    return 0;
}
int match3(char m[20], char a[20]) {
    FILE *fp;
    char account[20];
    char password[20];
    //文件不存在
    if ((fp = fopen("teacher.txt","r")) == NULL) {
        system ("cls");
        printf("\n还未存在用户!请先注册账号");
        getch();
        system("cls");
        mainmenu();
    }
    for (;!feof(fp); ) {
        fscanf(fp,"%s%s",account,password);
        if ((strcmp(m, account) == 0)) {
            if (strcmp(a,password) == 0) {
                return 1;
            } else {
                return -1;
            }
        }
    }
    return 0;
}
int match4(char m[20], char a[20]) {
    FILE *fp;
    char account[20];
    char password[20];
    //文件不存在
    if ((fp = fopen("manger.txt","r")) == NULL) {
        system ("cls");
        printf("\n还未存在用户!请先注册账号");
        getch();
        system("cls");
        mainmenu();
    }
    for (;!feof(fp); ) {
        fscanf(fp,"%s%s",account,password);
        if ((strcmp(m, account) == 0)) {
            if (strcmp(a,password) == 0) {
                return 1;
            } else {
                return -1;
            }
        }
    }
    return 0;
}
//学生登录函数
void land3(Student *L) {
    Student *pa;
    char account[20];
    char password[20];
    int i = 2;
    int j = 0, p, flag;
    char ch;
    char mima[20], mima2[20], temp2[20];
    system("cls");
    printf("【注】初次登陆，账号为\'学号+三个0\',初始密码即为你的学号,\n如你的学号为01001,,则账号为\'01001000\',密码为\'01001\'\n");
    do {
        flag = 1;
        printf("请输入账号: \n");
        scanf("%s",temp2);
        for (p = 0; p < strlen(temp2); p++) {
            if (temp2[p] >= 'A' && temp2[p] <= 'z' || strlen(temp2) != 8) {
                printf("输入错误，账号只能为8位且不能包含字母\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(account, temp2);
    memset(Search, 0, sizeof(char) * 20);
    strncpy(Search, account, 5);
    pa = findstudent(L);
    memset(Search2, 0, sizeof(char) * 20);
    strcpy(Search2, pa->class1);
    printf("请输入密码:\n");
    while ((ch = getch()) != 13) {
        if (ch == '\b') {
            j--;
            printf("\b");
            printf(" ");
            printf("\b");
        }
        else if(ch != 13){
            mima[j++] = ch;
            printf("*");
        } else {
            break;
        }
    }
    mima[j] = '\0';
    strcpy(password, mima);
    i = match2(account, password);
    if (i == 1) {
        printf("\n登陆成功!按任意键继续");
        getch();
        system("cls");
    } else {
        if (i == -1) {
            printf("密码错误!请重新输入");
            getch();
            land3(L);
        }
        if (i == 0) {
            printf("不存在此用户!请重新输入");
            getch();
            land3(L);
        }
    }
}
void land2() {
    char account[20];
    char password[20];
    int i = 2;
    int j = 0, p, flag;
    char ch;
    char mima[20], mima2[20], temp2[20];
    system("cls");
    do {
        flag = 1;
        printf("请输入您的账号: \n");
        scanf("%s",temp2);
        for (p = 0; p < strlen(temp2); p++) {
            if (temp2[p] >= 'A' && temp2[p] <= 'z' || strlen(temp2) != 8) {
                printf("输入错误，账号只能为8位且不能包含字母\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(account, temp2);
    printf("请输入您的密码:\n");
    while ((ch = getch()) != 13) {
        if (ch == '\b') {
            j--;
            printf("\b");
            printf(" ");
            printf("\b");
        }
        else if(ch != 13){
            mima[j++] = ch;
            printf("*");
        } else {
            break;
        }
    }
    mima[j] = '\0';
    strcpy(password, mima);
    i = match3(account, password);
    if (i == 1) {
        printf("\n登陆成功!按任意键继续");
        getch();
        system("cls");
    } else {
        if (i == -1) {
            printf("密码错误!请重新输入");
            getch();
            land2();
        }
        if (i == 0) {
            printf("不存在此用户!请重新输入");
            getch();
            land2();
        }
    }
}
void land4(Student *L) {
    char account[20];
    char password[20];
    int i = 2;
    int j = 0, p, flag;
    char ch;
    char mima[20], mima2[20], temp2[20];
    system("cls");
    do {
        flag = 1;
        printf("请输入您的账号: \n");
        scanf("%s",temp2);
        for (p = 0; p < strlen(temp2); p++) {
            if (temp2[p] >= 'A' && temp2[p] <= 'z' || strlen(temp2) != 8) {
                printf("输入错误，账号只能为8位且不能包含字母\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(account, temp2);
    printf("请输入您的密码:\n");
    while ((ch = getch()) != 13) {
        if (ch == '\b') {
            j--;
            printf("\b");
            printf(" ");
            printf("\b");
        }
        else if(ch != 13){
            mima[j++] = ch;
            printf("*");
        } else {
            break;
        }
    }
    mima[j] = '\0';
    strcpy(password, mima);
    i = match4(account, password);
    if (i == 1) {
        printf("\n登陆成功!按任意键继续");
        getch();
        system("cls");
    } else {
        if (i == -1) {
            printf("密码错误!请重新输入");
            getch();
            land2();
        }
        if (i == 0) {
            printf("不存在此用户!请重新输入");
            getch();
            land2();
        }
    }
}
//新建账户密码
void xinjian() {
    system("cls");
    FILE *fp;
    int n = 0, i;
    char ch;
    int flag, j, flag2;
    if ((fp = fopen("land.txt","r"))==NULL) {
        fp = fopen("land.txt","w");
        fclose(fp);
    }
    fp = fopen("land.txt","a+");
    while(1) {
        char mima[20] = {0}, mima2[20] = {0};
        char account[20] = {0}, temp2[20] = {0};
        char account1[20] = {0}, password2[20] = {0};
        char password[20] = {0}, password1[20] = {0};
        j = 0;
        n = 0;
        do {
            rewind(fp);
            flag = 1;
            flag2 = 1;
            printf("请输入账号: \n");
            scanf("%s",temp2);
            for (;!feof(fp);) {
                fscanf(fp,"%s%s",account1,password2);
                if ((strcmp(temp2, account1) == 0)) {
                    printf("该账号已存在！请重新创建\n");
                    flag2 = 0;
                    break;
                }
            }
            for (j = 0; j < strlen(temp2); j++) {
                if (temp2[j] >= 'A' && temp2[j] <= 'z' || strlen(temp2) != 8) {
                    printf("输入错误，账号只能为8位且不能包含字母\n");
                    flag = 0;
                    break;
                }
            }
        } while (flag == 0 || flag2 == 0);
        strcpy(account, temp2);
        printf("请输入密码: \n");
        while ((ch = getch()) != 13) {
            if (ch == '\b') {
                n--;
                printf("\b");
                printf(" ");
                printf("\b");
            }
            else if(ch != 13){
                mima[n++] = ch;
                printf("*");
            } else {
                break;
            }
        }
        mima[n] = '\0';
        strcpy(password, mima);
        printf("\n再次输入密码:\n");
        n = 0;
        while ((ch = getch()) != 13) {
            if (ch == '\b') {
                n--;
                printf("\b");
                printf(" ");
                printf("\b");
            }
            else if(ch != 13){
                mima2[n++] = ch;
                printf("*");
            } else {
                break;
            }
        }
        mima2[n] = '\0';
        strcpy(password1, mima2);
        if(strcmp(password,password1) == 0) {
            fprintf(fp,"%s %s\n",account, password);
            break;
        } else {
            printf("\n两次输入密码不一致，请重新注册:\n");
        }
    }
    fclose(fp);
    printf("\n注册成功，按任意键返回");
    getch();
    system("cls");
}
//新建账户密码2
void xinjian2() {
    FILE *fp;
    int i = 0, j, flag, flag2;
    int flag3 = 1;
    char ch;
    printf("1.学生\n2.教师\n3.管理员\n");
    printf("请输入对象: \n");
    int n;
    char choice[20];
    do {
        scanf("%s",choice);
        if (strcmp(choice, "1") == 0) {
            fp = fopen("land.txt","a+");
        } else if(strcmp(choice, "2") == 0) {
            fp = fopen("teacher.txt","a+");
        } else if(strcmp(choice, "3") == 0) {
            fp = fopen("manger.txt","a+");
        } else {
            flag3 = 0;
            printf("输入错误，请检查输入!按任意键返回");
            getch();
            system("cls");
            xinjian2();
        }
    } while(flag3 == 0);
    system("cls");
    while(1) {
        char mima[20] = {0}, mima2[20] = {0};
        char account[20] = {0}, temp2[20] = {0};
        char account1[20] = {0}, password2[20] = {0};
        char password[20] = {0}, password1[20] = {0};
        j = 0;
        n = 0;
        do {
            rewind(fp);
            flag = 1;
            flag2 = 1;
            printf("请输入账号: \n");
            scanf("%s",temp2);
            for (;!feof(fp);) {
                fscanf(fp,"%s%s",account1,password2);
                if ((strcmp(temp2, account1) == 0)) {
                    printf("该账号已存在！请重新创建\n");
                    flag2 = 0;
                    break;
                }
            }
            for (j = 0; j < strlen(temp2); j++) {
                if (temp2[j] >= 'A' && temp2[j] <= 'z' || strlen(temp2) != 8) {
                    printf("输入错误，账号只能为8位且不能包含字母\n");
                    flag = 0;
                    break;
                }
            }
        } while (flag == 0 || flag2 == 0);
        strcpy(account, temp2);
        printf("请输入密码: \n");
        while ((ch = getch()) != 13) {
            if (ch == '\b') {
                n--;
                printf("\b");
                printf(" ");
                printf("\b");
            }
            else if(ch != 13){
                mima[n++] = ch;
                printf("*");
            } else {
                break;
            }
        }
        mima[n] = '\0';
        strcpy(password, mima);
        printf("\n再次输入密码:\n");
        n = 0;
        while ((ch = getch()) != 13) {
            if (ch == '\b') {
                n--;
                printf("\b");
                printf(" ");
                printf("\b");
            }
            else if(ch != 13){
                mima2[n++] = ch;
                printf("*");
            } else {
                break;
            }
        }
        mima2[n] = '\0';
        strcpy(password1, mima2);
        if(strcmp(password,password1) == 0) {
            fprintf(fp,"%s %s\n",account, password);
            break;
        } else {
            printf("\n两次输入密码不一致，请重新注册:\n");
        }
    }
    fclose(fp);
    printf("\n创建成功，继续创建请按/'1 回车/'，退出请按/'2 回车/'\n");
    scanf("%d",&n);
    if (n == 1) {
        xinjian2();
    } else {
        printf("创建结束，按任意键返回!");
    }
    getch();
    system("cls");
}
//开始界面1
void Start1() {
    system("color F");
    printf("\n\t\t\t欢迎来到学生管理系统\n");
    printf("\n\t\t***********************************\n");
    printf("\n\t\t\t1.登录系统\n");
    printf("\n\t\t\t2.注册账号\n");
    printf("\n\t\t\t3.修改密码\n");
    printf("\n\t\t\t4.退出系统\n");
    printf("\n\t\t***********************************\n");
    printf("【注:】请输入对应选项前面的序号，如:想登录系统，请输入: 1 /'回车(enter)/'\n");
}
//开始界面2
void Start2() {
    system("color F");
    printf("\n\t\t\t请输入你想要进入的登录界面:\n");
    printf("\n\t\t***********************************\n");
    printf("\n\t\t\t1.学生登录\n");
    printf("\n\t\t\t2.教师登录\n");
    printf("\n\t\t\t3.管理员登录\n");
    printf("\n\t\t\t4.返回上一层\n");
    printf("\n\t\t\t5.退出系统\n");
    printf("\n\t\t***********************************\n");
    printf("【注:】请输入对应选项前面的序号，如:想进入学生登录界面，请输入: 1 /'回车(enter)/'\n");
}
//学生主界面
void Student1() {
    printf("\n\t\t同学，你好，欢迎来到学生管理系统！\n\n");
    printf("\t\t*************************************\n");
    printf("\n\t\t1.成绩查询 \n");
    printf("\n\t\t2.查询本班成绩 \n");
    printf("\n\t\t3.成绩分析 \n");
    printf("\n\t\t4.成绩申诉 \n");
    printf("\n\t\t5.返回上一层 \n");
    printf("\n\t\t0.退出系统\n");
    printf("\n\t\t****************************************\n");
}
//教师主界面
void Teacher() {
    printf("\n\t\t老师，您好，欢迎进入学生管理系统！\n\n");
    printf("\t\t*************************************\n");
    printf("\n\t\t1.增加新的学生信息 \n");
    printf("\n\t\t2.删除学生信息 \n");
    printf("\n\t\t3.修改学生信息 \n");
    printf("\n\t\t4.查询学生信息 \n");
    printf("\n\t\t5.输出本班成绩 \n");
    printf("\n\t\t6.下载到文件中 \n");
    printf("\n\t\t7.成绩分析 \n");
    printf("\n\t\t8.提醒管理员进行成绩的更新 \n");
    printf("\n\t\t9.返回上一层 \n");
    printf("\n\t\t0.退出系统\n");
    printf("\n\t\t****************************************\n");
}
//管理员主界面
void Manger() {
    printf("\t\t管理员，您好，欢迎进入学生管理系统！\n");
    printf("\t\t*************************************\n");
    printf("\t\t1.查看代办事项 \n");
    printf("\n\t\t2.进入教师端进行信息修改 \n");
    printf("\n\t\t3.增加账号及密码 \n");
    printf("\n\t\t4.删除账号及密码 \n");
    printf("\n\t\t5.修改密码 \n");
    printf("\n\t\t6.查找账号及密码 \n");
    printf("\n\t\t7.录入所有账号及密码 \n");
    printf("\n\t\t8.输出所有账号及密码 \n");
    printf("\n\t\t9.手动重新录入学生信息 \n");
    printf("\n\t\ta.返回上一层 \n");
    printf("\n\t\t0.退出系统\n");
    printf("\t\t****************************************\n");
    getchar();
}
//计算班级排名函数
int Bjpm(Student *L, Student *p) {
    Student *pa = L->next;
    int sum = 0;
    int count = 1;
    int sum1 = 0;
    sum1 = p->score[0] + p->score[1] + p->score[2];
    while (pa) {
        sum = 0;
        sum = pa->score[0] + pa->score[1] + pa->score[2];
        if (sum > sum1  && strcmp(pa->class1, p->class1) == 0) {
            count++;
        } else {
            ;
        }
        pa = pa->next;
    }
    return count;
}
//计算全级排名函数
int Qjpm(Student *L, Student *p) {
    Student *pa = L->next;
    int sum = 0;
    int count = 1;
    int sum1 = p->score[0] + p->score[1] + p->score[2];
    while (pa) {
        sum = 0;
        sum = pa->score[0] + pa->score[1] + pa->score[2];
        if (sum > sum1) {
            count++;
        } else {
            ;
        }
        pa = pa->next;
    }
    return count;
}
void Cjfx(Student *L) {
    char num1[20], temp[20];
    int count1 = 0, count2 = 0;
    int i, flag;
    Student *p=L->next;
    strcpy(num1, Search);
    //memset(Search, 0, sizeof(char) * 20);
    while (p && strcmp(p->num , num1) != 0) {
        p=p->next;
    }
    printstudent(p);
    printf("%s,你好，这是你的成绩分析: \n",p->name);
    printf("你的总分为: %d\n",p->score[0] + p->score[1] + p->score[2]);
    count1 = Bjpm(L, p);
    count2 = Qjpm(L, p);
    printf("你的班级排名为: 第%d名\n",count1);
    printf("你的全级排名为: 第%d名\n",count2);
    if (p->score[0] < 60) {
        printf("此次考试你的语文成绩为%d分，显得稍弱,希望你好好练字，多积累好词好句，争取下次能够及格!\n",p->score[0]);
    }
    if (p->score[1] < 60) {
        printf("此次考试你的数学成绩为%d分,显得稍弱，希望你上课注意记笔记，好好听讲，下去认真做习题，争取下次能够及格!\n",p->score[1]);
    }
    if (p->score[2] < 60) {
        printf("此次考试你的英语成绩为%d分,显得稍弱，希望你多记单词，多背诵英语文章，上课注意听讲语法知识，争取下次能够及格!\n",p->score[2]);
    }
    if (p->score[0] == 100) {
        printf("恭喜你此次考试语文获得满分，请继续努力保持优秀!\n");
    }
    if (p->score[1] == 100) {
        printf("恭喜你此次考试数学获得满分，请继续努力保持优秀!\n");
    }
    if (p->score[2] == 100) {
        printf("恭喜你此次考试英语获得满分，请继续努力保持优秀!\n");
    }
    printf("按任意键继续\n");
    getch();
}
//成绩申诉
void Cjss(Student *L) {
    char words[200];
    char num1[20], temp[20];
    int i, flag;
    Student *p = L->next;
    FILE *fp;
    strcpy(num1, Search);
    //memset(Search, 0, sizeof(char) * 20);
    while (p && strcmp(p->num , num1) != 0) {
        p=p->next;
    }
    printstudent(p);
    printf("请输入申诉理由: \n");
    scanf("%s",words);
    fp = fopen("申诉.txt","wt");
    if (fp == NULL) {
        printf("文件打开失败!");
        getchar();
        exit(1);
    }
    fprintf(fp,"%s\n",p->name);
    fprintf(fp,"%s ",words);
    printf("申诉成功!\n");
    fclose(fp);
    printf("按任意键返回!\n");
    getch();
}
//成绩申诉3
void Cjss3() {
    FILE *fp;
    char filename[100];
    char ch;
    fp = fopen("申诉.txt","rt");
    if (fp == NULL) {
        printf("文件打开失败,申诉.txt可能不存在\n");
        exit(1);
    }
    printf("申诉结果如下:\n");
    while((ch = fgetc(fp)) != EOF)
        printf("%c",ch);
    fclose(fp);
    printf("\n");
    printf("按任意键返回!");
    getch();
    system("cls");
}
//提醒更新成绩
void Cjss1() {
    char name[20];
    int flag;
    printf("1.网络1班\n2.网络2班\n3.网络3班\n4.网络4班\n5.网络5班\n");
    do {
        flag = 1;
        printf("尊敬的老师，请输入你所在班级对应的序号: \n");
        int choice;
        scanf("%d",&choice);
        if (choice == 1) {
            strcpy(name, "网络1班老师");
        } else if (choice == 2) {
            strcpy(name, "网络2班老师");
        } else if (choice == 3) {
            strcpy(name, "网络3班老师");
        } else if (choice == 4) {
            strcpy(name, "网络4班老师");
        } else if (choice == 5) {
            strcpy(name, "网络5班老师");
        } else {
            printf("输入错误！请重新输入\n");
            flag = 0;
        }
    } while(flag == 0);
    char words[200] = {"请及时更新成绩!!!\n"};
    FILE *fp;
    fp = fopen("提醒.txt","wt");
    if (fp == NULL) {
        printf("文件打开失败!");
        getchar();
        exit(1);
    }
    fprintf(fp,"\n%s提醒你: %s ",name, words);
    printf("已将提醒发送给管理员!\n");
    fclose(fp);
    printf("按任意键返回!\n");
    getch();
    system("cls");
}
//提醒更新成绩
void Cjss4() {
    FILE *fp;
    char filename[100];
    char ch;
    fp = fopen("提醒.txt","rt");
    if (fp == NULL) {
        printf("文件打开失败,提醒.txt可能不存在\n");
        exit(1);
    }
    printf("提醒结果如下:\n");
    while((ch = fgetc(fp)) != EOF)
        printf("%c",ch);
    fclose(fp);
    printf("\n");
    printf("按任意键返回!");
    getch();
    system("cls");
}
//寻找前驱节点
Student *Find_before(Student* phead, Student* p) {
    if (!p) return NULL;
    Student *pbefore = phead;
    while (pbefore) {
        if (pbefore->next == p)
            return pbefore;
        pbefore = pbefore->next;
    }
    return NULL;
}

Student *Sort(Student *head) {
    Student *pHead,*pEnd,*q = NULL,*qbefore = NULL,*p = NULL;
    int maxscore;
    pHead = pEnd = (Student*)malloc(sizeof(Student));
    while (head->next != NULL) {
        if (choice5 == 1) {
            maxscore = head->next->score[0];
            q = p = head->next;
        } else if (choice5 == 2) {
            maxscore = head->next->score[1];
            q = p = head->next;
        } else if (choice5 == 3) {
            maxscore = head->next->score[2];
            q = p = head->next;
        } else if (choice5 == 4) {
            maxscore = head->next->score[0] + head->next->score[1] + head->next->score[2];
            q = p = head->next;
        }
        //寻找最高分节点p
        if (choice5 == 1) {
            while (p->next!=NULL) {
                if(maxscore < p->next->score[0]) {
                    maxscore = p->next->score[0];
                    q = p->next;
                }
                p = p->next;
            }
        } else if (choice5 == 2) {
            while (p->next!=NULL) {
                if(maxscore < p->next->score[1]) {
                    maxscore = p->next->score[1];
                    q = p->next;
                }
                p = p->next;
            }
        } else if (choice5 == 3) {
            while (p->next!=NULL) {
                if(maxscore < p->next->score[2]) {
                    maxscore = p->next->score[2];
                    q = p->next;
                }
                p = p->next;
            }
        } else if (choice5 == 4) {
            while (p->next!=NULL) {
                if(maxscore < (p->next->score[0] + p->next->score[1] + p->next->score[2])) {
                    maxscore = (p->next->score[0] + p->next->score[1] + p->next->score[2]);
                    q = p->next;
                }
                p = p->next;
            }
        }
        qbefore = Find_before(head,q);  //寻找q节点的前驱节点
        qbefore->next = q->next; //将q的前驱节点指向q的后驱节点 从而将q节点从a链表中剔除
        pEnd->next = q;    //将头指针指向q
        q->next = NULL;    //q节点指向空
        pEnd = q;            //更新尾节点
    }
    free(head);//释放head链表头节点
    return pHead;
}
void Subject(Student *L) {
    Student *pa = L->next, *pb = NULL;
    printf("1.按语文成绩排序\n");
    printf("2.按数学成绩排序\n");
    printf("3.按英语成绩排序\n");
    printf("4.按总分成绩排序\n");
    printf("请输入: \n");
    scanf("%d",&choice5);
    pb = Sort(pa);
    Output(pb);
    printf("按任意键返回!\n");
    getch();
}
//班级成绩分析
void Cjfx2(Student *L) {
    char class2[20];
    int choice;
    int count_C = 0, count_M = 0, count_E = 0;
    int count = 0;
    int count_C1 = 0, count_M1 = 0, count_E1 = 0;
    float count_CR, count_MR, count_ER;
    Student *pa = L->next, *pb = L->next;
    printf("1.网络1班\n2.网络2班\n3.网络3班\n4.网络4班\n5.网络5班\n");
    printf("请输入你想要分析的班级对应的序号: \n");
    scanf("%d",&choice);
    if (choice == 1) {
        strcpy(class2,"网络1班");
    } else if(choice == 2) {
        strcpy(class2,"网络2班");
    } else if(choice == 3) {
        strcpy(class2,"网络3班");
    }else if(choice == 4) {
        strcpy(class2,"网络4班");
    }else if(choice == 5) {
        strcpy(class2,"网络5班");
    }
    if (strcmp(class2, "网络1班") != 0 &&
        strcmp(class2, "网络2班") != 0 &&
        strcmp(class2, "网络3班") != 0 &&
        strcmp(class2, "网络4班") != 0 &&
        strcmp(class2, "网络5班") != 0 ) {
        printf("输入的班级不存在，请重试!\n");
        Cjfx2(L);
    }
    while (pa) {
        if (strcmp(pa->class1, class2) == 0) {
            if (pa->score[0] == 100) {
                count_C++;
            }
            if (pa->score[1] == 100) {
                count_M++;
            }
            if (pa->score[2] == 100) {
                count_E++;
            }
            if (pa->score[0] >= 60) {
                count_C1++;
            }
            if (pa->score[1] >= 60) {
                count_M1++;
            }
            if (pa->score[2] >= 60) {
                count_E1++;
            }
        }
        count_CR = count_C1 / 31.0;
        count_MR = count_M1 / 31.0;
        count_ER = count_E1 / 31.0;
        pa = pa->next;
    }
    printf("%s成绩分析如下: \n",class2);
    printf("\t\t语文获得满分有%d人\n\t\t数学获得满分有%d人\n\t\t英语获得满分有%d人\n",count_C, count_M, count_E);
    printf("\t\t语文及格率为%.2f%%\n\t\t数学及格率为%.2f%%\n\t\t英语及格率为%.2f%%\n",count_CR * 100, count_MR * 100, count_ER * 100);
    printf("按任意键继续!");
    getch();
    Subject(pb);
    //printf("按任意键返回!");
    //getch();
}
//学生功能
void Student_fun() {
    Student *L;
    L = read();
    char choice[20];
    int flag;
    do {
        scanf("%s",choice);
        system("cls");
        if(strcmp(choice, "1") == 0) {
            flag = 1;
            L = findstudent(L);
            printstudent(L);
            system("cls");
            Student1();
            Student_fun();
            break;
        } else if(strcmp(choice, "2") == 0) {
            flag = 1;
            chaxun(L);
            system("cls");
            Student1();
            Student_fun();
            break;
        } else if(strcmp(choice, "3") == 0) {
            flag = 1;
            Cjfx(L);
            system("cls");
            Student1();
            Student_fun();
            break;
        } else if(strcmp(choice, "4") == 0) {
            flag = 1;
            Cjss(L);
            system("cls");
            Student1();
            Student_fun();
            break;
        } else if(strcmp(choice, "5") == 0) {
            flag = 1;
            land1();
            system("cls");
            Student1();
            Student_fun();
            break;
        } else if(strcmp(choice, "0") == 0) {
            flag = 1;
            printf("退出成功，感谢您的使用");
            exit(0);;
        } else {
            flag = 0;
            system("cls");
            printf("输入错误，请检查输入!按任意键继续");
            getch();
            system("cls");
            Student1();
            Student_fun();
        }
    } while(flag == 0);
}
//教师功能
void Teacher_fun() {
    Student *L;
    L = read();
    int flag;
    char choice[20];
    do {
        scanf("%s",choice);
        system("cls");
        if(strcmp(choice, "1") == 0) {
            flag = 1;
            L = InsList(L);
            system("cls");
            File4(L);
            Teacher();
            Teacher_fun();
            break;
        } else if (strcmp(choice, "2") == 0) {
            flag = 1;
            L = deletestudent(L);
            File4(L);
            system("cls");
            Teacher();
            Teacher_fun();
            break;
        } else if(strcmp(choice, "3") == 0) {
            flag = 1;
            L = modifystudent(L);
            File4(L);
            system("cls");
            Teacher();
            Teacher_fun();
            break;
        } else if(strcmp(choice, "4") == 0) {
            flag = 1;
            find(L);
            system("cls");
            Teacher();
            Teacher_fun();
            break;
        } else if(strcmp(choice, "5") == 0) {
            flag = 1;
            chaxun2(L);
            system("cls");
            Teacher();
            Teacher_fun();
            break;
        } else if(strcmp(choice, "6") == 0) {
            flag = 1;
            File5(L);
            system("cls");
            Teacher();
            Teacher_fun();
            break;
        } else if(strcmp(choice, "7") == 0) {
            flag = 1;
            Cjfx2(L);
            system("cls");
            Teacher();
            Teacher_fun();
            break;
        } else if(strcmp(choice, "8") == 0) {
            flag = 1;
            Cjss1();
            system("cls");
            Teacher();
            Teacher_fun();
            break;
        } else if(strcmp(choice, "9") == 0) {
            flag = 1;
            land1();
            break;
        } else if(strcmp(choice, "0") == 0) {
            flag = 1;
            printf("退出成功，感谢您的使用");
            exit(0);
        } else {
            flag = 0;
            system("cls");
            printf("输入错误，请检查输入!按任意键继续");
            getch();
            system("cls");
            Teacher();
            Teacher_fun();
        }
    } while (flag == 0);
}
void zhaohui(Student *L) {
    FILE *fp;
    Student *pa = L->next, *pb;
    char account[20], temp2[20], account1[20], password2[20], temp1[20], class5[20];
    int flag, flag2, j;
    fp = fopen("land.txt", "rt");
    do {
        //rewind(fp);
        flag = 1;
        printf("请输入你要找回的账号: \n");
        scanf("%s",temp2);
        for (j = 0; j < strlen(temp2); j++) {
            if (temp2[j] >= 'A' && temp2[j] <= 'z' || strlen(temp2) != 8) {
                printf("输入错误，账号只能为8位且不能包含字母\n");
                flag = 0;
                break;
            }
        }
    } while (flag == 0);
    strcpy(account, temp2);
    memset(Search, 0, sizeof(char) * 20);
    strncpy(Search, account, 5);
    pb = findstudent(pa);
    for (;!feof(fp);) {
        fscanf(fp,"%s%s",account1,password2);
        if ((strncmp(account, account1, 8) == 0)) {
            printf("请回答以下问题: \n");
            do {
                flag = 1;
                printf("请输入该账号学生的姓名: \n");
                scanf("%s",temp1);
                for (j = 0; j < strlen(temp1); j++) {
                    if (temp1[j] >= '0' && temp1[j] <= '9') {
                        printf("姓名不得包含数字，请重新输入!\n");
                        flag = 0;
                        break;
                    }
                }
            } while (flag == 0);
            printf("请输入该账号学生所在班级: \n");
            scanf("%s",class5);
            if (strcmp(class5, pb->class1) == 0 && strcmp(temp1, pb->name) == 0) {
                printf("找回成功!\n");
                printf("您的密码: \n%s\n",password2);
                break;
            } else {
                printf("答案有错误，按任意键返回");
                getch();
                system("cls");
                Manger();
                Manger_fun(L);
            }
        }
    }
    printf("按任意键继续\n");
    getch();
    system("cls");
}
void wait(Student *L) {
    char choice[20];
    int flag;
    Student *pa = L->next;
    printf("1.成绩申诉\n2.更新成绩库\n3.找回密码\n");
    do {
        flag = 1;
        scanf("%s",choice);
        if (strcmp(choice, "1") == 0) {
            Cjss3();
        } else if(strcmp(choice, "2") == 0) {
            Cjss4();
        } else if(strcmp(choice, "3") == 0) {
            zhaohui(L);
        } else {
            flag = 0;
            printf("输入错误，请检查并重新输入!,按任意键继续\n");
            getch();
            system("cls");
            wait(L);
        }
    } while(flag == 0);
}
//管理员功能
void Manger_fun(Student *L) {
    Student *pa = L->next;
    int flag;
    char choice[20];
    do {
        scanf("%s",choice);
        system("cls");
        if(strcmp(choice, "1") == 0) {
            flag = 1;
            wait(pa);
            Manger();
            Manger_fun(L);
            break;
        } else if(strcmp(choice, "2") == 0) {
            flag = 1;
            Teacher();
            Teacher_fun();
            Manger();
            Manger_fun(L);
            break;
        } else if(strcmp(choice, "3") == 0) {
            flag = 1;
            append();
            Manger();
            Manger_fun(L);
            break;
        } else if(strcmp(choice, "4") == 0) {
            flag = 1;
            Dele();
            Manger();
            Manger_fun(L);
            break;
        } else if(strcmp(choice, "5") == 0) {
            flag = 1;
            xgmm();
            Manger();
            Manger_fun(L);
            break;
        } else if(strcmp(choice, "6") == 0){
            flag = 1;
            chazhao2();
            Manger();
            Manger_fun(L);
            break;
        } else if(strcmp(choice, "7") == 0) {
            flag = 1;
            xinjian2();
            system("cls");
            Manger();
            Manger_fun(L);
            break;
        } else if(strcmp(choice, "8") == 0) {
            flag = 1;
            File3();
            system("cls");
            Manger();
            Manger_fun(L);
            break;
        } else if(strcmp(choice, "9") == 0) {
            flag = 1;
            L = Create();
            Output(L);
            File(L);
            Manger();
            Manger_fun(L);
            break;
        } else if(strcmp(choice, "a") == 0) {
            flag = 1;
            land1();
            break;
        } else if(strcmp(choice, "0") == 0) {
            flag = 1;
            printf("退出成功，感谢您的使用");
            exit(0);
        } else {
            flag = 0;
            system("cls");
            printf("输入错误，请检查输入!按任意键继续");
            getch();
            system("cls");
            Manger();
            Manger_fun(L);
        }
    } while(flag == 0);
}
//登录界面
void land1() {
    Student *L;
    L = read();
    int flag;
    char choice[20];
    Start2();
    do {
        scanf("%s",choice);
        system("cls");
        if (strcmp(choice, "1") == 0) {
            flag = 1;
            land3(L);
            Student1();
            Student_fun();
            break;
        } else if(strcmp(choice, "2") == 0) {
            flag = 1;
            land2();
            Teacher();
            Teacher_fun();
            break;
        } else if(strcmp(choice, "3") == 0) {
            flag = 1;
            land4(L);
            Manger();
            Manger_fun(L);
            break;
        } else if(strcmp(choice, "4") == 0) {
            flag = 1;
            mainmenu();
            break;
        } else if(strcmp(choice, "5") == 0) {
            flag = 1;
            printf("退出成功，感谢您的使用");
            exit(0);
        } else {
            flag = 0;
            system("cls");
            printf("输入错误，请检查输入!按任意键继续");
            getch();
            system("cls");
            land1();
        }
    } while(flag == 0);
}
//主菜单
void mainmenu() {
    char a[20];
    int flag;
    Start1();
    do {
        scanf("%s",a);
        if (strcmp(a,"1") == 0) {
            flag = 1;
            land();
            land1();
            break;
        }else if(strcmp(a,"2") == 0) {
            flag = 1;
            xinjian();
            mainmenu();
            break;
        }else if(strcmp(a,"3") == 0) {
            flag = 1;
            xgmm();
            mainmenu();
            break;
        }else if(strcmp(a,"4") == 0){
            flag = 1;
            printf("退出成功，感谢您的使用");
            exit(0);
        } else {
            flag = 0;
            system("cls");
            printf("输入错误，请检查输入!按任意键继续");
            getch();
            system("cls");
            mainmenu();
        }
    }while(flag == 0);
}
int main() {
    mainmenu();
    return 0;
}
