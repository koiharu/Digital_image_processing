function display_hog_visualization(grayImg, lineImg, visualizationOrig, visualizationLine)
    % 显示HOG特征可视化结果
    figure;
    subplot(1,2,1);
    imshow(grayImg);
    hold on;
    plot(visualizationOrig);
    title('原始图像 HOG');

    subplot(1,2,2);
    imshow(lineImg);
    hold on;
    plot(visualizationLine);
    title('直线图像 HOG');
end
