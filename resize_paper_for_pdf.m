function fig_handle = resize_paper_for_pdf( fig_handle )

    fig_units = get(fig_handle, 'Units'); 

    set(fig_handle,'Units','Inches');
    pos = get(fig_handle,'Position');
    set(fig_handle,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    set(fig_handle, 'Units', fig_units );

end