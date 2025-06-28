<%-- 
    Document   : FilterTool
    Created on : Jun 28, 2025, 5:18:39 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
   <form class="row g-3 align-items-end mb-4" method="get" action="search">
            <input type="hidden" name="keyword" value="<%= request.getAttribute("keyword") %>" />
            <div class="col-md-3">
                <label class="form-label">Khoảng giá</label>
                <select class="form-select" name="price">
                    <option value="">Tất cả</option>
                    <option value="0-5000000">Dưới 5 triệu</option>
                    <option value="5000000-10000000">5 - 10 triệu</option>
                    <option value="10000000-20000000">10 - 20 triệu</option>
                    <option value="20000000-999999999">Trên 20 triệu</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">Đánh giá</label>
                <select class="form-select" name="rating">
                    <option value="">Tất cả</option>
                    <option value="5">5 ★</option>
                    <option value="4">4 ★ trở lên</option>
                    <option value="3">3 ★ trở lên</option>
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label">Sắp xếp theo</label>
                <select class="form-select" name="sort">
                    <option value="">Mặc định</option>
                    <option value="price_asc">Giá tăng dần</option>
                    <option value="price_desc">Giá giảm dần</option>
                    <option value="name_asc">Tên A-Z</option>
                    <option value="name_desc">Tên Z-A</option>
                    <option value="id_desc">Mới nhất</option>
                    <option value="id_asc">Cũ nhất</option>
                </select>
            </div>
            <div class="col-md-1">
                <button type="submit" class="btn btn-primary w-100"><i class="fa fa-filter"></i> Lọc</button>
            </div>
        </form>
