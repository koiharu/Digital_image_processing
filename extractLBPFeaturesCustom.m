function lbpFeatures = extractLBPFeaturesCustom(image)
    % 手动实现 LBP 特征提取
    % 输入: image - 灰度图像
    % 输出: lbpFeatures - LBP 特征向量

    % 检查图像是否为灰度图
    if size(image, 3) == 3
        image = rgb2gray(image);
    end

    % 初始化 LBP 图像
    [rows, cols] = size(image);
    lbpImage = zeros(rows - 2, cols - 2, 'uint8');

    % 权重矩阵，按顺时针方向定义
    weights = [1, 2, 4; 128, 0, 8; 64, 32, 16];

    % LBP 特征计算
    for i = 2:rows-1
        for j = 2:cols-1
            % 取 3x3 邻域像素
            neighborhood = image(i-1:i+1, j-1:j+1);
            centerPixel = neighborhood(2, 2);

            % 比较中心像素与邻域像素，生成二值化矩阵
            binaryPattern = double(neighborhood >= centerPixel);

            % 计算 LBP 值
            lbpValue = sum(binaryPattern .* weights, 'all') - binaryPattern(2, 2) * weights(2, 2);
            lbpImage(i-1, j-1) = lbpValue;
        end
    end

    % 将 LBP 图像转换为特征向量
    lbpFeatures = histcounts(lbpImage, 0:256, 'Normalization', 'probability');
end
