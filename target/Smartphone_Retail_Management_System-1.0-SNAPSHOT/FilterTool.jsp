<%-- 
    Document   : FilterTool
    Created on : Jun 28, 2025, 5:18:39 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
   <form class="row g-3 align-items-end mb-4" method="post" action="search">
            <input type="hidden" name="keyword" value="<%= request.getAttribute("keyword") %>" />
            <div class="col-md-3">
                <label class="form-label">Price Range</label>
                <select class="form-select" name="price">
                    <option value="">All</option>
                    <option value="0-5000000">Under 5 million</option>
                    <option value="5000000-10000000">5 - 10 million</option>
                    <option value="10000000-20000000">10 - 20 million</option>
                    <option value="20000000-999999999">Over 20 million</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">Rating</label>
                <select class="form-select" name="rating">
                    <option value="">All</option>
                    <option value="5">5 ★</option>
                    <option value="4">4 ★ and above</option>
                    <option value="3">3 ★ and above</option>
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label">Sort by</label>
                <select class="form-select" name="sort">
                    <option value="">Default</option>
                    <option value="price_asc">Price: Low to High</option>
                    <option value="price_desc">Price: High to Low</option>
                    <option value="name_asc">Name: A-Z</option>
                    <option value="name_desc">Name: Z-A</option>
                    <option value="id_desc">Newest</option>
                    <option value="id_asc">Oldest</option>
                </select>
            </div>
            <div class="col-md-1">
                <button type="submit" class="btn btn-primary w-100"><i class="fa fa-filter"></i> Filter</button>
            </div>
        </form>
