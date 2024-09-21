﻿$(document).ready(function () {
    function loadTable() {
        var tbody = $("#infoTable").find('tbody');
        tbody.empty();
        tbody.append('<tr><td colspan="4">Dữ liệu trống</td></tr>');

        $.post('api.aspx', { action: 'get_infor' }, function (data) {
            tbody.empty();
            if (data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    var member = data[i];
                    var hangMoi = $("<tr></tr>");
                    hangMoi.append($("<td></td>").text(member.ma_thanh_vien));
                    hangMoi.append($("<td></td>").text(member.ten));
                    hangMoi.append($("<td></td>").text(getTenViTri(member.ma_vi_tri)));
                    hangMoi.append($("<td></td>").html(
                        `<button class="edit-btn" onclick="chinhSuaHang(${member.ma_thanh_vien}, this)">Sửa</button>
                         <button class="delete-btn" onclick="xoaHang(${member.ma_thanh_vien}, this)">Xóa</button>
                         <button class="history-btn" onclick="xemLs(${member.ma_thanh_vien})">Lịch sử</button>`
                    ));
                    tbody.append(hangMoi);
                }
            } else {
                tbody.append('<tr><td colspan="4">Không có dữ liệu nào.</td></tr>');
            }
        }, 'json');
    }

    function getTenViTri(viTri) {
        switch (viTri) {
            case 1:
                return 'KTX';
            case 2:
                return 'Nhà trọ';
            case 3:
                return 'Trường';
            case 4:
                return 'Chợ';
            case 5:
                return 'Không biết';
            default:
                return 'Không xác định';
        }
    }

    function themHang() {
        var ten = $("#nameInput").val();
        if (ten == '') {
            alert("Nhập tên đi");
            return;
        }
        $("#nameInput").val("");
        var viTri = parseInt($("#locationInput").val());

        $.post('api.aspx', { action: 'add', ten: ten, ma_vi_tri: viTri }, function (data) {
            if (data.ok) {
                $("#nameInput").val("");
                $("#locationInput").val("1");  
            } else {
                alert("Thêm thành công");
                loadTable();
            }
        }, 'json');
    }

    window.xoaHang = function (ma_thanh_vien, button) {
        $.post('api.aspx', { action: 'delete', ma_thanh_vien: ma_thanh_vien }, function (data) {
            if (data.ok) {
                $(button).closest('tr').remove();
            } else {
                alert('Xoá thành công');
                loadTable();
            }
        }, 'json');
    }

    window.chinhSuaHang = function (ma_thanh_vien,button) {
        var hang = $(button).closest('tr');
        var oViTri = hang.find('td').eq(2);
        var viTriHienTai = oViTri.text();

        oViTri.attr('data-vi-tri-cu', viTriHienTai);
        oViTri.html(`
            <select class='editable'>
                <option value='1' ${viTriHienTai === 'KTX' ? 'selected' : ''}>KTX</option>
                <option value='2' ${viTriHienTai === 'Nhà trọ' ? 'selected' : ''}>Nhà trọ</option>
                <option value='3' ${viTriHienTai === 'Trường' ? 'selected' : ''}>Trường</option>
                <option value='4' ${viTriHienTai === 'Chợ' ? 'selected' : ''}>Chợ</option>
                <option value='5' ${viTriHienTai === 'Không biết' ? 'selected' : ''}>Không biết</option>
            </select>
        `);

        $(button).replaceWith(`<button class='save-btn' onclick='luuHang(${ma_thanh_vien}, this)'>Lưu</button>`);
    }

    window.luuHang = function (ma_thanh_vien,button) {
        var hang = $(button).closest('tr');
        var viTri = parseInt(hang.find('select').val());  

        $.post('api.aspx', { action: 'update', ma_thanh_vien: ma_thanh_vien, ma_vi_tri: viTri }, function (data) {
            if (data.ok) {
                hang.find('td').eq(1).text(getTenViTri(viTri));
                $(button).replaceWith(`<button class="edit-btn" onclick="chinhSuaHang(${ma_thanh_vien}, this)">Sửa</button>`);
            } else {
                alert('Chỉnh sửa thành công');
                loadTable();
            }
        }, 'json');
    }

    window.xemLs = function (ma_thanh_vien) {
        var gui_di = { action: 'history', ma_thanh_vien: ma_thanh_vien };

        $.post('api.aspx', gui_di, function (data) {
            console.log('Dữ liệu lịch sử nhận về:', data);
            var json = data;

            if (Array.isArray(json) && json.length > 0) {
                var tb = '<table class="table">';
                tb += '<thead><tr><th>Tên</th><th>Vị trí</th><th>Thời gian</th></tr></thead>';
                tb += '<tbody>';

                for (var item of json) {
                    tb += `<tr>
                    <td>${item.ten}</td>
                    <td>${getTenViTri(item.ma_vi_tri)}</td>
                    <td>${item.thoi_gian}</td>
                </tr>`;
                }

                tb += '</tbody></table>';
                console.log('Mở dialog với nội dung:', tb);

                $('#dialog').html(tb);
                $('#dialog').dialog({
                    title: 'Lịch sử vị trí',
                    width: 600,
                    modal: true
                });
            } else {
                console.log('Lỗi:', tb);

                $('#dialog').html('<p>Không có lịch sử nào được tìm thấy.</p>');
                $('#dialog').dialog({
                    title: 'Thông báo',
                    width: 400,
                    modal: true
                });
            }
        }, 'json');
    };

    function checkPositions() {
        $.post('api.aspx', { action: 'check_diadiem' }, function (data) {
            if (data.thoigian) {
                alert("Tất cả sinh viên đều ở trường tại :"+data.thoigian);
            }
        }, 'json');
    }


    $(".add-btn").click(themHang);
    loadTable();
    setInterval(function () {
        loadTable(); 
    }, 5000);
    setTimeout(function () {
        checkPositions();
    }, 5000);
    setInterval(function () {
        checkPositions();
    }, 50000);
});
