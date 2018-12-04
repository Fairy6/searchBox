package com.wr.servlet;

import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wr on 2018/12/3.
 */
public class SearchServlet extends HttpServlet{
    static List<String> datas = new ArrayList<>();
    //模拟数据
    static{
        datas.add("ajax");
        datas.add("ajax post");
        datas.add("becky");
        datas.add("bill");
        datas.add("james");
        datas.add("jerry");
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //处理编码格式
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        //首先获得客户端发送来的数据keyword
        String keyword = request.getParameter("keyword");
        //获得关键字之后进行处理，得到关联数据
        List<String> listData = getData(keyword);
        //返回jason格式
        //JSONArray.fromObject(listData);
        System.out.println(JSONArray.fromObject(listData));
        response.getWriter().write(JSONArray.fromObject(listData).toString());
    }

    //获得关联数据的方法
    public List<String> getData(String keyword){
        List<String> list = new ArrayList<>();
        for (String data : datas){
           if (data.contains(keyword)){
               list.add(data);
           }
        }
        return list;
    }
}
