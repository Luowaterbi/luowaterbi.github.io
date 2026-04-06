---
permalink: /
title: ""
excerpt: ""
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---
{% if site.google_scholar_stats_use_cdn %}
{% assign gsDataBaseUrl = "https://cdn.jsdelivr.net/gh/" | append: site.repository | append: "@" %}
{% else %}
{% assign gsDataBaseUrl = "https://raw.githubusercontent.com/" | append: site.repository | append: "/" %}
{% endif %}
{% assign url = gsDataBaseUrl | append: "google-scholar-stats/gs_data_shieldsio.json" %}

<span class='anchor' id='about-me'></span>

Hello! I am a forth-year PhD student in the [Language Analysis Group](https://hit-scir-la.github.io/) at [HIT-SCIR](https://ir.hit.edu.cn/main.htm), under the supervision of [Prof. Wanxiang Che](https://chewanxiang.com/) and [Assoc. Prof. Qingfu Zhu](https://ir.hit.edu.cn/2024/1021/c19599a356032/page.htm). 

<!-- , supervised by [Houyi Li](https://scholar.google.com/citations?user=LkqxJqoAAAAJ&hl=en) and [Zili Wang](https://commencement.github.io/). -->

My primary research interest is **Code Intelligence**. I focus on identifying and addressing bottlenecks across the full pipeline: Pretrain, Post-Train, Application and Acceleration of Inference.

If you are interested in my research or potential collaborations, please feel free to reach out to me at [xzluo@ir.hit.edu.cn](xzluo@ir.hit.edu.cn)~🎉

I am interest in algorithm competitions. During my undergraduate years, I participated in various programming contests and served as the president of the *Programming and Algorithms Association* and vice president of the [Federation of Student Associations](https://xsh.hrbeu.edu.cn/8746/list.htm).

# 🔥 News
- *2026.04*: 🎉 Our [Scaling Law for Code](https://arxiv.org/abs/2510.08702) is accepted by ACL 2026! Our [Format-Adapter](https://arxiv.org/abs/2506.23133) is accepted by findings of ACL 2026! Congratulations to all our collaborators!
- *2026.02*: 🔥 We release [CVE-Factory](https://github.com/livecvebench/CVE-Factory), including [training data](https://huggingface.co/Luoberta/cve_train), [Abacus-cve model](https://huggingface.co/Luoberta/Abacus-cve), [LiveCVEBench](https://github.com/livecvebench/LiveCVEBench-Preview), and [Leaderboard](https://livecvebench.github.io)!
- *2026.01*: 🎉 Our [How Many Code and Test Cases Are Enough?](https://arxiv.org/abs/2510.08720) is accepted by ICLR 2026!
- *2025.12*: 🔥 Our survey [A Practical Guide to Code Intelligence](https://arxiv.org/abs/2511.18538) is publicly available! Honored to have participated as a core contributor.
- *2025.07*: 🎉 Our [Token Recycling](https://aclanthology.org/2025.acl-long.338/) is selected as <span class="outstanding-tag">ACL2025 Outstanding Paper</span>!
- *2025.06*: 🎉 Our [Token Recycling](https://aclanthology.org/2025.acl-long.338/) and [OpenCoder](https://aclanthology.org/2025.acl-long.1591/) are selected as **Oral** presentation at ACL2025! See you in Vienna! 🇦🇹
- *2025.05*:  🎉 Our [Token Recycling](https://aclanthology.org/2025.acl-long.338/), [ChartCoder](https://aclanthology.org/2025.acl-long.363/), [OpenCoder](https://aclanthology.org/2025.acl-long.1591/) are accepted by ACL 2025! Our [ChartEdit](https://aclanthology.org/2025.findings-acl.185/) is accepted by findings of ACL 2025! And [Tool-MVRL](https://dl.acm.org/doi/10.1145/3711896.3736835) is accepted by KDD 2025! Congratulations to all our collaborators!
- *2024.09*:  🎉 Our [MultiPoT](https://arxiv.org/abs/2402.10691) and [Make Some Noise](https://arxiv.org/abs/2406.17404) are accepted by EMNLP 2024! Congratulations to all our collaborators!
- *2024.09*: 🔥 We release [Abacus](https://github.com/HIT-SCIR/Abacus), a 2.7B Code LLM, complete with open weights and detailed training documentation!

# 📝 Publications

## Pretrain
- <span class="preprint-tag">ACL 2026</span> [Scaling Laws for Code: A More Data-Hungry Regime](https://arxiv.org/abs/2510.08702), **Xianzhen Luo<sup>†</sup>**, Wenzhen Zheng<sup>†</sup>, Qingfu Zhu, Rongyi Zhang, Houyi Li, Siming Huang, Yuantao Fan, Wanxiang Che.
- <span class="conference-tag">ACL 2025</span> <span class="oral-tag">Oral</span> [OpenCoder: The Open Cookbook for Top-Tier Code Large Language Models](https://aclanthology.org/2025.acl-long.1591/), Siming Huang, Tianhao Cheng, Jason Klein Liu, Weidi Xu, JIARAN HAO, Liuyihan Song, Yang Xu, Jian Yang, Jiaheng Liu, Chenchen Zhang, Linzheng Chai, Ruifeng Yuan, **Xianzhen Luo**, Qiufeng Wang, YuanTao Fan, Qingfu Zhu, Zhaoxiang Zhang, Yang Gao, Jie Fu, Qian Liu, Houyi Li, Ge Zhang, Yuan Qi, Xu Yinghui, Wei Chu, Zili Wang.
- <span class="tech-report-tag">Tech Report</span> [Step-3 is Large yet Affordable: Model-system Co-design for Cost-effective Decoding](https://stepfun.ai/research/en/step3), **Core Contributor**.
- <span class="preprint-tag">Arxiv 2025</span> [Is Compression Really Linear with Code Intelligence?](https://arxiv.org/abs/2505.11441), Shijie Xuyang<sup>†</sup>, **Xianzhen Luo<sup>†</sup>**, Zheng Chu, Houyi Li, Siming Huang, Qiufeng Wang, Wanxiang Che, Qingfu Zhu, Shuigeng Zhou.

## Post-Train
- <span class="preprint-tag">Arxiv 2026</span> [CVE-Factory: Scaling Expert-Level Agentic Tasks for Code Security Vulnerability](https://arxiv.org/abs/2602.03012), Xianzhen Luo<sup>†</sup>, Jingyuan Zhang<sup>†</sup>, Shiqi Zhou<sup>†</sup>, Rain Huang<sup>†</sup>, Chuan Xiao, Qingfu Zhu, Zhiyuan Ma, Xing Yue, Yang Yue, Wencong Zeng, Wanxiang Che.
- <span class="conference-tag">ACL 2025</span> [ChartCoder: Advancing Multimodal Large Language Model for Chart-to-Code Generation](https://aclanthology.org/2025.acl-long.363/), Xuanle Zhao<sup>†</sup>, **Xianzhen Luo<sup>†</sup>**, Qi Shi, Chi Chen, Shuo Wang, Zhiyuan Liu, Maosong Sun.
- <span class="conference-tag">KDD 2025</span> [Advancing Tool-Augmented Large Language Models via Meta-Verification and Reflection Learning](https://dl.acm.org/doi/10.1145/3711896.3736835), Zhiyuan Ma, Jiayu Liu, **Xianzhen Luo**, Zhenya Huang, Qingfu Zhu, Wanxiang Che.
- <span class="conference-tag">EMNLP 2024</span> [Make Some Noise: Unlocking Language Model Parallel Inference Capability through Noisy Training](https://arxiv.org/abs/2406.17404), Yixuan Wang<sup>†</sup>, **Xianzhen Luo<sup>†</sup>**, Fuxuan Wei, Yijun Liu, Qingfu Zhu, Xuanyu Zhang, Qing Yang, Dongliang Xu, Wanxiang Che.
- <span class="preprint-tag">Arxiv 2025</span> [Success is in the Details: Evaluate and Enhance Details Sensitivity of Code LLMs through Counterfactuals](https://arxiv.org/abs/2505.14597), **Xianzhen Luo**, Qingfu Zhu, Zhiming Zhang, Mingzheng Xu, Tianhao Cheng, Yixuan Wang, Zheng Chu, Shijie Xuyang, Zhiyuan Ma, YuanTao Fan, Wanxiang Che.
- <span class="preprint-tag">Arxiv 2025</span> [Automated Snippet-Alignment Data Augmentation for Code Translation](https://arxiv.org/abs/2510.15004), Zhiming Zhang, Qingfu Zhu, **Xianzhen Luo**, Yixuan Wang, Bohan Li, Wanxiang Che.
- <span class="preprint-tag">Arxiv 2024</span> [Semi-Instruct: Bridging Natural-Instruct and Self-Instruct for Code Large Language Models](https://arxiv.org/abs/2403.00338), **Xianzhen Luo**, Qingfu Zhu, Zhiming Zhang, Xu Wang, Qing Yang, Dongliang Xu, Wanxiang Che.

## Inference
- <span class="preprint-tag">ACL 2026 (Findings)</span> [Format-Adapter: Improving Reasoning Capability of LLMs by Adapting Suitable Format](https://arxiv.org/abs/2506.23133), Dingzirui Wang, Xuanliang Zhang, Rongyu Cao, Longxu Dou, **Xianzhen Luo**, Yingwei Ma, Qingfu Zhu, Wanxiang Che, Binhua Li, Fei Huang, Yongbin Li.
- <span class="conference-tag">ICLR 2026</span> [How Many Code and Test Cases Are Enough? Evaluating Test Cases Generation from a Binary-Matrix Perspective](https://arxiv.org/abs/2510.08720), **Xianzhen Luo<sup>†</sup>**, Jinyang Huang<sup>†</sup>, Wenzhen Zheng, Qingfu Zhu, Mingzheng Xu, Yiheng Xu, Yuantao Fan, Libo Qin, Wanxiang Che.
- <span class="conference-tag">ACL 2025</span> <span class="outstanding-tag">Outstanding Paper</span> [Turning Trash into Treasure: Accelerating Inference of Large Language Models with Token Recycling](https://aclanthology.org/2025.acl-long.338/), **Xianzhen Luo**, Yixuan Wang, Qingfu Zhu, Zhiming Zhang, Xuanyu Zhang, Qing Yang, Dongliang Xu.
- <span class="conference-tag">ACL 2025 (Findings)</span> [ChartEdit: How Far Are MLLMs From Automating Chart Analysis? Evaluating MLLMs' Capability via Chart Editing](https://aclanthology.org/2025.findings-acl.185/), Xuanle Zhao<sup>†</sup>, Xuexin Liu<sup>†</sup>, Yang Haoyue<sup>†</sup>, **Xianzhen Luo**, Fanhu Zeng, Jianling Li, Qi Shi, Chi Chen.
- <span class="conference-tag">EMNLP 2024</span> [Python is Not Always the Best Choice: Embracing Multilingual Program of Thoughts](https://arxiv.org/abs/2402.10691), **Xianzhen Luo**, Qingfu Zhu, Zhiming Zhang, Libo Qin, Xuanyu Zhang, Qing Yang, Dongliang Xu, Wanxiang Che.

## Survey
- <span class="conference-tag">LREC-COLING 2024</span> [A Survey on Natural Language Processing for Programming](https://aclanthology.org/2024.lrec-main.149/), Qingfu Zhu, **Xianzhen Luo**, Fang Liu, Cuiyun Gao, Wanxiang Che.
- <span class="tech-report-tag">Survey</span> [From Code Foundation Models to Agents and Applications: A Practical Guide to Code Intelligence](https://arxiv.org/abs/2511.18538), **Core Contributor**.

## Others
- <span class="conference-tag">ACL 2022 (Findings)</span> [Inverse is better! fast and accurate prompt for few-shot slot tagging](https://aclanthology.org/2022.findings-acl.53/), Yutai Hou, Cheng Chen, **Xianzhen Luo**, Bohan Li, Wanxiang Che.
- <span class="conference-tag">AI Open, 2022</span> [Augmented and challenging datasets with multi-step reasoning and multi-span questions for Chinese judicial reading comprehension](https://www.sciencedirect.com/science/article/pii/S2666651022000225),Qingye Meng, Ziyue Wang, Hang Chen, **Xianzhen Luo**, Baoxin Wang, Zhipeng Chen, Yiming Cui, Dayong Wu, Zhigang Chen, Shijin Wang.

<sup>†</sup> indicates equal contribution.

# 🎖 Honors and Awards
- *2025.10* Merit Student (三好学生) of Heilongjiang Province.
- *2025.10* (PhD Student) National Scholarship.
- *2025.07* ACL Outstanding Paper.
- *2022.06* Outstanding Graduate.
- *2021.04* International Collegiate Programming Contest Asia-East Continent Final Contest: Bronze Medal.
- *2020.12* National Encouragement Scholarship.
- *2020.12* International Collegiate Programming Contest Asia Shanghai Regional Contest: Silver Medal.
- *2020.11* China Collegiate Programming Contest Mianyang Site: Silver Medal.
- *2020.10* Northeast Collegiate Programming Contest: First Prize.
- *2019.12* (Undergraduate) National Scholarship.
- *2019.12* International Collegiate Programming Contest Asia-East Continent Final Contest: Bronze Medal.
- *2019.11* International Collegiate Programming Contest Asia Shenyang Regional Contest: Silver Medal.

# 📖 Educations

- *2022.09 - now*, Ph.D. student, Harbin Institute of Technology.
- *2018.09 - 2022.07*, Undergraduate, Harbin Engineering University.

# 💬 Invited Talks
- *2026.02*, I was invited to give a talk at MLNLP to share our work **CVE-Factory: Scaling Expert-Level Agentic Tasks for Code Security Vulnerability**.
- *2025.08*, I was invited to give a talk at Alibaba International Consumer Business Unit to share and discuss our paper **Turning Trash into Treasure: Accelerating Inference of Large Language Models with Token Recycling**.
- *2024.03*, I was invited to give a talk at Qiyuan Lab about the **Training and Application of Code Large Language Models**.

<!-- - *2021.03*, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ornare aliquet ipsum, ac tempus justo dapibus sit amet.  \| [\[video\]](https://github.com/) -->

# 💻 Internships
- *2025.08 - 2026.3*, **KStar Research Intern**, [Kuaishou Technology](https://www.kuaishou.com/), China.
  - **Adviser**: [Jingyuan Zhang](https://scholar.google.com/citations?user=pdj-Em0AAAAJ&hl=zh-CN&oi=ao)
  - **Research Focus**: Scaling environments for code agents.

- *2024.12 - 2025.07*, **Research Intern**, [StepFun AI](https://www.stepfun.com/), China.
  - **Adviser**: [Xiangyu Zhang](https://scholar.google.com/citations?user=yuB-cfoAAAAJ&hl=en)
  - **Research Focus**: The code aspects of LLM pretraining.
  - **Key Contributions**: Developed code data cleaning, training & evaluation pipelines. Provided core code pretraining data for Step3 LLM. Implemented several specialized pretraining tasks/strategies on code.

- *2023.11 - 2024.09*, **University-Industry Collaboration Researcher**, [Du Xiaoman (Beijing) Science Technology Co., Ltd.](https://github.com/Duxiaoman-DI), China.
- *2022.03 - 2022.08*, **Research Intern**, [Joint Laboratory of HIT and iFLYTEK Research (HFL)](https://huggingface.co/hfl), China.