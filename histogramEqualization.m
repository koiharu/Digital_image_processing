function equalizedImage = histogramEqualization(image)
    % 如果输入是彩色图像，转换为灰度图像
    if size(image, 3) == 3
        image = rgb2gray(image);
    end

    % 获取图像的大小
    [rows, cols] = size(image);

    % 计算灰度直方图
    histogramCounts = imhist(image);

    % 计算累计分布函数（CDF）
    cdf = cumsum(histogramCounts) / (rows * cols);  % 归一化累计分布函数

    % 线性变换映射
    % CDF的最小值通常为0, 将其映射到灰度值[0, 255]区间
    mapping = round(cdf * 255);  

    % 使用映射将原始图像的像素值转换为均衡化后的像素值
    equalizedImage = mapping(double(image) + 1);  % `+1` 因为 MATLAB 索引从 1 开始

    % 将结果转换为 uint8 类型
    equalizedImage = uint8(equalizedImage);
end