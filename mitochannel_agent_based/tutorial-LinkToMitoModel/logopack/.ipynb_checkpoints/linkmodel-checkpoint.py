from pyNetLogo import core
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.patches import Circle
from matplotlib.collections import PatchCollection
import os

class linkmodel(core.NetLogoLink):
    def __init__(self, model_path, gui=False, setmodel=True):
        super().__init__(gui=gui)
        super().load_model(model_path)
        if set:
            self.setup()

    def setup(self):
        super().command('setup')
    #def go():


    def repglobal(self, indexes=['cx', 'cy', 'dim_dom', 'diam_nuc', 'dt', 'sec', 'minute', 'hour', 'ds'
        , 'mito-step_far', 'mito-step_close', 'EN_stress_level', 'vel_far', 
        'vel_close', 'vel_far2', 'vel_close2', 'initial_tot_number', 'MR_th', 
        'prob_fusIn', 'prob_fisIn', 'prob_biogenesisIn', 'prob_damIn', 'dam_th', 
        'totmass', 'critMass', 'min_mito_mass', 'max_mito_mass', 'small', 'mid', 
        'big', 'counter', 'freq_fusionIn', 'freq_fissionIn', 'freq_degIn', 'freq_bioIn', 
        'totmassGreen', 'totmassDam', 'totmassLow', 'totmassHigh']):
        """
        Report global variable 
        Argument:
            indexes: list of global variable names (string)
        Return:
            glob: dictionary type {index: report-variable}
        """
        self.glob = {}

        for index in indexes:
            self.glob[index] = self.report(index)
        
        return self.glob

    def repagents(self, breed_name= 'mitos',indexes=['who','xcor','ycor']):
        """
        Report variable list of agents
        Argument:
            indexes: list of agent variable names (string)
        Return:
            agents: dictionary type {'ids': agent id array, 'indexes': list of report-variables array}
        """
        self.agents = {}

        # Put 'who' index in the front
        if not 'who' in indexes:
            indexes = 'who' + indexes
        
        for index in indexes:
            self.agents[index] = self.report('map [ s -> [' + index + '] of s] sort ' + breed_name)
            
        return self.agents

    def plotcell(self, figsize=(10,10)):
            """
            Plot Cell image and mitochondria
            Argument:
                    dic: dictionary load from model with key:
                            1. cx: central of cell
                            2. cy: central of cell
                            3. diam_nuc: nucleus diameter
                            4. dim_dom: cell diameter
            """
            fig, ax = plt.subplots(figsize=figsize)
            plt.axis([0, self.glob['dim_dom'], 0, self.glob['dim_dom']])

            # Add patches
            patches = []
            patches.append(Circle((self.glob['cx'],self.glob['cy']),self.glob['diam_nuc']/2.0)) # Nucleus
            patches.append(Circle((self.glob['cx'],self.glob['cy']),self.glob['dim_dom']/2.0)) # Cell

            # define collection
            p = PatchCollection(patches, alpha=0.4)

            plt.title('Mitochondria Location')
            ax.scatter(self.agents['xcor'], self.agents['ycor'], s=4)
            ax.set_xlabel('xcor')
            ax.set_ylabel('ycor')
            ax.set_aspect('equal')
            ax.add_collection(p)

            return fig, ax