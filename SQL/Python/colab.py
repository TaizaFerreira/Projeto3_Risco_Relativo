# Criação do gráfico da matriz de confusão

import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import pandas as pd

# Matriz de confusão
conf_matrix = np.array([[622, 83],
                        [158, 35675]])

# Criar DataFrame para melhor legenda
df_cm = pd.DataFrame(
    conf_matrix,
    index=['Inadimplente (Real)', 'Adimplente (Real)'],
    columns=['Inadimplente (Previsto)', 'Adimplente (Previsto)']
)

# Plotar como mapa de calor
plt.figure(figsize=(6,4))
sns.heatmap(df_cm, annot=True, fmt='d', cmap='Greens')
plt.title("Matriz de Confusão - Score de Risco")
plt.ylabel("Situação Real")
plt.xlabel("Previsão do Modelo")
plt.tight_layout()
plt.savefig("matriz_confusao.png")
plt.show()





## aperfeiçoando gráfico matriz de confusão

import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import pandas as pd

# Valores da matriz
vp = 622
fn = 83
fp = 158
vn = 35675
total = vp + fn + fp + vn

# Matriz com valores absolutos
matriz_valores = np.array([[vp, fn], [fp, vn]])

# Matriz com porcentagens
matriz_percent = np.array([[vp / total, fn / total],
                           [fp / total, vn / total]])

# Texto combinado (valor + %)
labels = np.array([[f"{vp}\n({vp/total:.2%})", f"{fn}\n({fn/total:.2%})"],
                   [f"{fp}\n({fp/total:.2%})", f"{vn}\n({vn/total:.2%})"]])

# Criar o heatmap
plt.figure(figsize=(7, 5))
sns.heatmap(matriz_valores,
            annot=labels,
            fmt='',
            cmap='Greens',
            xticklabels=['Previsto Inadimplente', 'Previsto Adimplente'],
            yticklabels=['Inadimplente (Real)', 'Adimplente (Real)'],
            cbar=False,  # Remove a barra lateral
            linewidths=1, linecolor='gray')

plt.title("Matriz de Confusão - Modelo de Risco", 
          fontsize=14, 
          color='#006400',        # Verde escuro (DarkGreen)
          fontweight='bold', 
          style='italic')
plt.xlabel("Previsão do Modelo", fontsize=12)
plt.ylabel("Situação Real", fontsize=12)
plt.tight_layout()
plt.savefig("matriz_confusao_completa.png", dpi=300)
plt.show()





## Baixando imagem para usar no looker studio

from google.colab import files
files.download("matriz_confusao_completa.png")