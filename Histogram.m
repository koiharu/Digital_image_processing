function result = Histogram(image)
    if size(image, 3) == 3
        image = customGrayScale(image);
    end

    histogramCounts = imhist(image);

     % 绘制直方图
    figure;
    bar(0:255, histogramCounts, 'BarWidth', 1, 'FaceColor', 'b');
    xlim([0 255]);
    title('灰度直方图');
    xlabel('灰度值');
    ylabel('像素数量');
    grid on;

    result =  unit8(gcf);
    close;
end
