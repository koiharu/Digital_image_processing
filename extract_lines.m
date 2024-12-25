function lineImg = extract_lines(grayImg)
    % 使用Canny边缘检测算法提取边缘
    BW = edge(grayImg, 'Canny');

    % 计算霍夫变换
    [H, T, R] = hough(BW);

    % 找到前5个霍夫变换峰值
    P = houghpeaks(H, 5);

    % 提取直线
    lines = houghlines(BW, T, R, P);

    % 创建一个空白图像并绘制直线
    lineImg = zeros(size(grayImg));
    for k = 1:length(lines)
        % 获取每条直线的端点
        x = [lines(k).point1(1), lines(k).point2(1)];
        y = [lines(k).point1(2), lines(k).point2(2)];
        lineImg(sub2ind(size(lineImg), round(y), round(x))) = 255;
    end
end