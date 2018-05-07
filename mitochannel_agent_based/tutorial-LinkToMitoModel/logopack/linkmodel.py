"""
logopack Package

Author: Shao-Ting Chiu (Deptartment of Electrical Engineering, National Taiwan Univ., b03901045@ntu.edu.tw)
Github: https://github.com/stevengogogo

Goal: Inherit pyNetLogo library, and provide common usage for Mitochondria NetLogo Model.

pyNetLogo documentation: https://pynetlogo.readthedocs.io/
Mitochondrial NetLogo Model: http://journals.plos.org/plosone/article/file?type=supplementary&id=info:doi/10.1371/journal.pone.0168198.s009

Reference: Agent-Based Modeling of Mitochondria Links Sub-Cellular Dynamics to Cellular Homeostasis and Heterogeneity
           (https://doi.org/10.1371/journal.pone.0168198)
"""

from pyNetLogo import core
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.patches import Circle
from matplotlib.collections import PatchCollection
import os

class linkmodel(core.NetLogoLink):
    def __init__(self, model_path, gui=False, setmodel=True, 
        global_indexes=['cx', 'cy', 'dim_dom', 'diam_nuc', 'dt', 'sec', 'minute', 'hour', 'ds'
        , 'mito-step_far', 'mito-step_close', 'EN_stress_level', 'vel_far', 
        'vel_close', 'vel_far2', 'vel_close2', 'initial_tot_number', 'MR_th', 
        'prob_fusIn', 'prob_fisIn', 'prob_biogenesisIn', 'prob_damIn', 'dam_th', 
        'totmass', 'critMass', 'min_mito_mass', 'max_mito_mass', 'small', 'mid', 
        'big', 'counter', 'freq_fusionIn', 'freq_fissionIn', 'freq_degIn', 'freq_bioIn', 
        'totmassGreen', 'totmassDam', 'totmassLow', 'totmassHigh'],
        agent_indexes=['who','xcor','ycor']):
        """
        Create and inherit a pyNetLogo objecgt, and provide customize operation for mitochondrial NetLogo model.
        Arguments:
                model_path:        Path to netlogo model
                gui:               Use netlogolink command to link to model. In Windows, this can also provide NetLogo native GUI, but Mac can't due to pyNetLogo bugs (Default: False)
                setmodel:          Usually NetLogo model needs "setup" command to beginning simulation, Default True to setup the model
                global_indexes:    define which global variables are concerned in the model. Default is referenced from mitochondrial netlogo model.
                agent_indexes:     define which agent variable are concerned in the model. Default is referenced from mitochondrial netlogo model.
        """

        # Use inherit pyNetLogo command
        super().__init__(gui=gui)
        super().load_model(model_path)


        self.global_indexes= global_indexes
        self.agent_indexes = agent_indexes

        if setmodel:
            self.setup()

    def setup(self):
        """
        Proceed "setup" command in NetLogo. In Netlogo, setup command is usually used to assign variables. setup function can proceed stup and update variables.
        """

        super().command('setup')
        self.update_var()

    def go(self, steps=1):
        """
        proceed "go" command in NetLogo. In NetLogo, go command is usually used to proceed a model. This function can proceed the model and update variables
        Argument:
                steps: number of steps
        """

        super().command('repeat '+str(steps)+' [go]')
        self.update_var()

    def update_var(self, breed_name='mitos'):
        """
        Update all the global's and agents' variables by default indexes defined in __init__
        Argument:
            breed_name: Breed name (string). If indexes are none, assert default 'mitos'
        """

        # Update global and agents variables to self
        _ = self.repglobal()
        _ = self.repagents(breed_name=breed_name)

    def repglobal(self, indexes= None):
        """
        Report global variable 
        Argument:
            indexes:  list of global variable names (string)
        Return:
            glob:     dictionary type {index: report-variable}
        """

        if indexes == None:
            indexes = self.global_indexes
        self.glob = {}

        for index in indexes:
            self.glob[index] = self.report(index)
        
        return self.glob

    def repagents(self, breed_name= 'mitos',indexes= None):
        """
        Report variable list of agents
        Argument:
            breed_name: Breed name (string). If indexes are none, assert default indexes
        Return:
            agents:     dictionary type {'ids': agent id array, 'indexes': list of report-variables array}
        """

        # Check breed_name exists. If not, return None
        if self.report('count '+breed_name) == 0.0:
            return None

        if indexes == None:
            indexes = self.agent_indexes

        self.agents = {}

        # Put 'who' index in the front
        if not 'who' in indexes:
            indexes = 'who' + indexes
        
        # Using report command in pyNetLogo
        for index in indexes:
            self.agents[index] = self.report('map [ s -> [' + index + '] of s] sort ' + breed_name)
            
        return self.agents

    def plotcell(self, title='Mitochondria Location',figsize=(10,10)):
            """
            Plot Cell image and mitochondria
            Argument:
                    title:      title of the plot
                    figsize:    using command- matplotlib.pyplot.figure(figsize)
            Return: 
                    fig, ax:    matplotlib.pyplot object
            """

            self.update_var()
            fig, ax = plt.subplots(figsize=figsize)
            plt.axis([0, self.glob['dim_dom'], 0, self.glob['dim_dom']])

            # Add patches
            patches = []
            patches.append(Circle((self.glob['cx'],self.glob['cy']),self.glob['diam_nuc']/2.0)) # Nucleus
            patches.append(Circle((self.glob['cx'],self.glob['cy']),self.glob['dim_dom']/2.0)) # Cell

            # define collection
            p = PatchCollection(patches, alpha=0.4)

            plt.title(title)
            ax.scatter(self.agents['xcor'], self.agents['ycor'], s=4)
            ax.set_xlabel('xcor ($\mu m$)')
            ax.set_ylabel('ycor ($\mu m$)')
            ax.set_aspect('equal')
            ax.add_collection(p)

            return fig, ax