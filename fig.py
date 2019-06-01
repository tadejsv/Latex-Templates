import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc
from cycler import cycler

# Set up fonts
rc('text.latex',preamble=r'\usepackage[charter,cal=cmcal]{mathdesign}')
rc('text',usetex=True)
rc('font', family='serif', size=11)

# Set up colors
colors = ['#0077BB', '#EE7733', '#009988', '#CC3311', '#33BBEE', '#EE3377']
rc('axes', prop_cycle = cycler(c=colors))

# Plot
x = np.linspace(-np.pi, np.pi, int(1e3))
fig, ax = plt.subplots(figsize=(6,4))
ax.plot(x, np.sin(x), label=rf'$\sin(x)$')

for i in range(1,6):
    ax.plot(x, np.sin(x + i*np.pi/6), 
            label=r'$\sin\left(x+ \frac{' + str(i) + r'}{6}\pi\right)$')

# Label graph
ax.set_title('Some trig functions', fontsize=11)
ax.set_xlabel(r'$x$')
ax.set_ylabel(r'$f(x)$')

# Tweak legend and layout
plt.legend(loc='upper left', bbox_to_anchor=(1.05, 1), borderaxespad=0.)
plt.tight_layout()

# Save figure
fig.savefig('../../Dropbox (MIT)/Apps/Overleaf/Notes template/trig.pdf', 
            pad_inches=0, bbox_inches='tight')
