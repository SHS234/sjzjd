import type { MockMethod } from 'vite-plugin-mock';

export default [
  {
    url: '/api/announcement',
    method: 'get',
    response: () => ({
      code: 0,
      data: {
        list: [
          {
            id: 1,
            title: 'AI技术在医疗领域的创新应用与发展前景',
            summary:
              '本文探讨了人工智能技术在医疗诊断、药物研发和个性化治疗等方面的最新应用，分析了面临的挑战及未来的发展趋势。',
            content:
              '<p>随着人工智能技术的飞速发展，其在医疗领域的应用日益广泛。从辅助诊断到手术机器人，AI正在重塑医疗行业的未来...</p>',
            type: '社交',
            priority: 'high',
            status: 'published',
            coverUrl: 'https://tdesign.gtimg.com/site/source/card-demo.png',
            publishAt: new Date().toISOString(),
            createdAt: new Date().toISOString(),
            updatedAt: new Date().toISOString(),
            createdByName: 'Admin',
          },
          {
            id: 2,
            title: '大数据分析助力企业决策的实践案例',
            summary:
              '通过实际案例分析，阐述了企业如何利用大数据分析工具挖掘数据价值，优化业务流程，提升决策效率和市场竞争力。',
            content: '<p>在数字化转型的浪潮中，数据已成为企业最宝贵的资产之一。如何从海量数据中提取有价值的信息...</p>',
            type: '技术',
            priority: 'middle',
            status: 'published',
            coverUrl: 'https://tdesign.gtimg.com/site/source/card-demo.png',
            publishAt: new Date().toISOString(),
            createdAt: new Date().toISOString(),
            updatedAt: new Date().toISOString(),
            createdByName: 'Admin',
          },
          {
            id: 3,
            title: '区块链技术在供应链管理中的应用',
            summary:
              '介绍了区块链技术去中心化、不可篡改的特性在供应链追溯、物流透明化和供应链金融等场景中的应用优势和实施路径。',
            content: '<p>供应链管理的痛点在于信息不对称和信任缺失。区块链技术通过分布式账本...</p>',
            type: '科技',
            priority: 'low',
            status: 'published',
            coverUrl: 'https://tdesign.gtimg.com/site/source/card-demo.png',
            publishAt: new Date().toISOString(),
            createdAt: new Date().toISOString(),
            updatedAt: new Date().toISOString(),
            createdByName: 'Admin',
          },
          {
            id: 4,
            title: '云计算技术发展趋势与未来展望',
            summary:
              '深入分析了云计算技术的演进历程，探讨了混合云、边缘计算和云原生等新兴技术趋势，展望了云计算对数字经济的推动作用。',
            content: '<p>云计算作为数字经济的基石，正在进入一个新的发展阶段。企业上云已成为常态...</p>',
            type: '云技术',
            priority: 'high',
            status: 'published',
            coverUrl: 'https://tdesign.gtimg.com/site/source/card-demo.png',
            publishAt: new Date().toISOString(),
            createdAt: new Date().toISOString(),
            updatedAt: new Date().toISOString(),
            createdByName: 'Admin',
          },
        ],
        total: 4,
      },
    }),
  },
  {
    url: '/api/announcement/:id',
    method: 'get',
    response: () => {
      return {
        code: 0,
        data: {
          id: 1,
          title: 'AI技术在医疗领域的创新应用与发展前景',
          summary:
            '本文探讨了人工智能技术在医疗诊断、药物研发和个性化治疗等方面的最新应用，分析了面临的挑战及未来的发展趋势。',
          content:
            '<p>随着人工智能技术的飞速发展，其在医疗领域的应用日益广泛。从辅助诊断到手术机器人，AI正在重塑医疗行业的未来...</p>',
          type: '社交',
          priority: 'high',
          status: 'published',
          coverUrl: 'https://tdesign.gtimg.com/site/source/card-demo.png',
          publishAt: new Date().toISOString(),
          createdAt: new Date().toISOString(),
          updatedAt: new Date().toISOString(),
          createdByName: 'Admin',
        },
      };
    },
  },
] as MockMethod[];
