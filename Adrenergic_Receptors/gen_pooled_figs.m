function gen_pooled_figs( counts_struct )
    
    NeuronTypes = counts_struct.NeuronTypes;
    Animals = counts_struct.Animals;
    Receptors = counts_struct.Receptors;
    
    s = counts_struct;

    neuron_data = struct;
    for k = 1:length( NeuronTypes )

        receptor_avg = [];
        for j = 1:length( Receptors )

            data = [];
            for i = 1:length( Animals )
                data = vertcat( data, s.(Animals{i}).(Receptors{j}).(NeuronTypes{k}) );
            end

            data_ratios = data(:,3) ./ (data(:,2)+ data(:,3));
            receptor_avg = horzcat( receptor_avg, mean(data_ratios) );

        end

        neuron_data(k).neurontype = NeuronTypes(k);
        neuron_data(k).vals = receptor_avg;

    end


    % Plots
    for i = 1:length(neuron_data)

       figure();
       set(gcf, 'Position', [100 800 300 250]);
       bar( neuron_data(i).vals, 'k' )

       ylim( [0 1] );
       yticks( [0 0.2 0.4 0.6 0.8 1] );
       ylabel( {'Proportion of'; 'Receptor+ Neurons'} );

       xticklabels( {'Alpha1A', 'Alpha2A', 'Beta1', 'Beta2'} );
       set(gca,'FontSize', 12, 'FontWeight', 'Bold', 'xticklabelrotation', 45 );

       title( neuron_data(i).neurontype{1}, 'FontSize', 14, 'FontWeight', 'Bold');
       saveas( gcf, neuron_data(i).neurontype{1}, 'png' );
    end


end