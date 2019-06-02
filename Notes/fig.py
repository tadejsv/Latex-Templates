import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc
from cycler import cycler

# Set up fonts
rc('text.latex',preamble=r'\usepackage[charter, cal=cmcal]{mathdesign}')
rc('text',usetex=True)
rc('font', family='serif', size=11)

# Set up colors
colors = ['#0077BB', '#EE7733', '#009988', '#CC3311', '#33BBEE', '#EE3377']
rc('axes', prop_cycle = cycler(c=colors))

# Plot
x = np.linspace(-np.pi, np.pi, int(1e3))
fig, ax = plt.subplots(figsize=(5,4))
ax.plot(x, np.sin(x), label=rf'$\sin(x)$')

for i in range(1,6):
    ax.plot(x, np.sin(x + i*np.pi/6))

# Label graph
ax.set_title(r'Functions of the form $f(x) = \sin\left(x + \frac{k}{6}\pi\right)$'+\
             r' where $k \in \{0,1,2,3,4,5\}$', fontsize=11)
ax.set_xlabel(r'$x$')
ax.set_ylabel(r'$f(x)$')

# Tweak layout and save figure
plt.tight_layout()
fig.savefig('../../Dropbox (MIT)/Apps/Overleaf/Templates/Notes/trig.pdf', 
            pad_inches=0, bbox_inches='tight')