/* ****************************************************************************
 * $Revision: 79680 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-11-25 16:04:18 +0700 (Fri, 25 Nov 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Account%20Hierarchies%20-%20Tree%20Version%20Specify%20Nodes%20(Values%20within%20a%20range).sql $:
 * $Id: Manage Account Hierarchies - Tree Version Specify Nodes (Values within a range).sql 79680 2022-11-25 09:04:18Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT FndTreeEO.TREE_NAME                                                      RES_TREE_NAME
,FndTreeEO.TREE_CODE                                                            RES_TREE_CODE
,FndTreeEO.TREE_STRUCTURE_CODE                                                  RES_TREE_STRUCTURE_CODE
,FndTreeVersionEO.TREE_VERSION_NAME                                             RES_NAME
,'Values within a range'                                                        RES_TREE_NODE_TYPE
,(SELECT DATA_SOURCE_NAME 
	FROM FND_TS_DATA_SOURCE_VL
	WHERE DATA_SOURCE_ID = FndTreeNodeEO.DATA_SOURCE_ID
	AND TREE_STRUCTURE_CODE = FndTreeVersionEO.TREE_STRUCTURE_CODE
	)                                                                           RES_DATA_SOURCE
,LabelE0.LABEL_NAME                                                             RES_LABEL

,nvl(decode(DEPTH,1,PARENT_PK1_VALUE,'') , NVL(
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 1
                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                               )   
                                               ,
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 1
                                                and xxx.TREE_NODE_ID = NVL(
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 2
                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                           )   
                                                                           ,
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 2
                                                                            and xxx.TREE_NODE_ID = NVL(
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 3
                                                                                                        and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                       )   
                                                                                                       ,
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 3
                                                                                                        and xxx.TREE_NODE_ID = NVL(
                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                    where xxx.DEPTH = 4
                                                                                                                                    and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                   )   
                                                                                                                                   ,
                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                    where xxx.DEPTH = 4
                                                                                                                                    and xxx.TREE_NODE_ID = NVL(
                                                                                                                                                               (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                from FND_TREE_NODE xxx
                                                                                                                                                                where xxx.DEPTH = 5
                                                                                                                                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                               )   
                                                                                                                                                               ,
                                                                                                                                                               (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                from FND_TREE_NODE xxx
                                                                                                                                                                where xxx.DEPTH = 5
                                                                                                                                                                and xxx.TREE_NODE_ID = NVL(
                                                                                                                                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                            from FND_TREE_NODE xxx
                                                                                                                                                                                            where xxx.DEPTH = 6
                                                                                                                                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                                                           )   
                                                                                                                                                                                           ,
                                                                                                                                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                            from FND_TREE_NODE xxx
                                                                                                                                                                                            where xxx.DEPTH = 6
                                                                                                                                                                                            and xxx.TREE_NODE_ID = NVL(
                                                                                                                                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                        from FND_TREE_NODE xxx
                                                                                                                                                                                                                        where xxx.DEPTH = 7
                                                                                                                                                                                                                        and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                       )   
                                                                                                                                                                                                                       ,
                                                                                                                                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                        from FND_TREE_NODE xxx
                                                                                                                                                                                                                        where xxx.DEPTH = 7
                                                                                                                                                                                                                        and xxx.TREE_NODE_ID = NVL(
                                                                                                                                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                                                                                                                                    where xxx.DEPTH = 8
                                                                                                                                                                                                                                                    and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                                                   )   
                                                                                                                                                                                                                                                   ,
                                                                                                                                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                                                                                                                                    where xxx.DEPTH = 8
                                                                                                                                                                                                                                                    and xxx.TREE_NODE_ID = (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                                                                            from FND_TREE_NODE xxx
                                                                                                                                                                                                                                                                            where xxx.DEPTH = 9
                                                                                                                                                                                                                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                                                                            ) 
                                                                                                                                                                                                                                                   ) 
                                                                                                                                                                                                                                                 ) 
                                                                                                                                                                                                                       ) 
                                                                                                                                                                                                                     )
                                                                                                                                                                                           ) 
                                                                                                                                                                                         ) 
                                                                                                                                                               ) 
                                                                                                                                                            )
                                                                                                                                   ) 
                                                                                                                                )
                                                                                                       ) 
                                                                                                    )  
                                                                           ) 
                                                                        )  
                                               ) 
                                            )    
   )                                                                                                                                RES_PARENT_NODE_NAME_1
,nvl(decode(DEPTH,2,PARENT_PK1_VALUE,'') , NVL(
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 2
                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                               )   
                                               ,
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 2
                                                and xxx.TREE_NODE_ID = NVL(
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 3
                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                           )   
                                                                           ,
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 3
                                                                            and xxx.TREE_NODE_ID = NVL(
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 4
                                                                                                        and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                       )   
                                                                                                       ,
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 4
                                                                                                        and xxx.TREE_NODE_ID = NVL(
                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                    where xxx.DEPTH = 5
                                                                                                                                    and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                   )   
                                                                                                                                   ,
                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                    where xxx.DEPTH = 5
                                                                                                                                    and xxx.TREE_NODE_ID = NVL(
                                                                                                                                                               (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                from FND_TREE_NODE xxx
                                                                                                                                                                where xxx.DEPTH = 6
                                                                                                                                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                               )   
                                                                                                                                                               ,
                                                                                                                                                               (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                from FND_TREE_NODE xxx
                                                                                                                                                                where xxx.DEPTH = 6
                                                                                                                                                                and xxx.TREE_NODE_ID = NVL(
                                                                                                                                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                            from FND_TREE_NODE xxx
                                                                                                                                                                                            where xxx.DEPTH = 7
                                                                                                                                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                                                           )   
                                                                                                                                                                                           ,
                                                                                                                                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                            from FND_TREE_NODE xxx
                                                                                                                                                                                            where xxx.DEPTH = 7
                                                                                                                                                                                            and xxx.TREE_NODE_ID = NVL(
                                                                                                                                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                        from FND_TREE_NODE xxx
                                                                                                                                                                                                                        where xxx.DEPTH = 8
                                                                                                                                                                                                                        and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                       )   
                                                                                                                                                                                                                       ,
                                                                                                                                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                        from FND_TREE_NODE xxx
                                                                                                                                                                                                                        where xxx.DEPTH = 8
                                                                                                                                                                                                                        and xxx.TREE_NODE_ID = (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                                                from FND_TREE_NODE xxx
                                                                                                                                                                                                                                                where xxx.DEPTH = 9
                                                                                                                                                                                                                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                                                ) 
                                                                                                                                                                                                                       ) 
                                                                                                                                                                                                                     ) 
                                                                                                                                                                                           ) 
                                                                                                                                                                                         )
                                                                                                                                                               ) 
                                                                                                                                                             ) 
                                                                                                                                   ) 
                                                                                                                                )
                                                                                                       ) 
                                                                                                    )
                                                                           ) 
                                                                        )  
                                               ) 
                                            )     
   )                                                                                                                                   RES_PARENT_NODE_NAME_2
   
,NVL(decode(DEPTH,3,PARENT_PK1_VALUE,'') ,NVL(
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 3
                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                               )   
                                               ,
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 3
                                                and xxx.TREE_NODE_ID = NVL(
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 4
                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                           )   
                                                                           ,
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 4
                                                                            and xxx.TREE_NODE_ID = NVL(
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 5
                                                                                                        and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                       )   
                                                                                                       ,
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 5
                                                                                                        and xxx.TREE_NODE_ID = NVL(
                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                    where xxx.DEPTH = 6
                                                                                                                                    and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                   )   
                                                                                                                                   ,
                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                    where xxx.DEPTH = 6
                                                                                                                                    and xxx.TREE_NODE_ID = NVL(
                                                                                                                                                               (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                from FND_TREE_NODE xxx
                                                                                                                                                                where xxx.DEPTH = 7
                                                                                                                                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                               )   
                                                                                                                                                               ,
                                                                                                                                                               (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                from FND_TREE_NODE xxx
                                                                                                                                                                where xxx.DEPTH = 7
                                                                                                                                                                and xxx.TREE_NODE_ID = NVL(
                                                                                                                                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                            from FND_TREE_NODE xxx
                                                                                                                                                                                            where xxx.DEPTH = 8
                                                                                                                                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                                                           )   
                                                                                                                                                                                           ,
                                                                                                                                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                            from FND_TREE_NODE xxx
                                                                                                                                                                                            where xxx.DEPTH = 8
                                                                                                                                                                                            and xxx.TREE_NODE_ID = (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                                                                                                    where xxx.DEPTH = 9
                                                                                                                                                                                                                    and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                                                                                    ) 
                                                                                                                                                                                           ) 
                                                                                                                                                                                         ) 
                                                                                                                                                               ) 
                                                                                                                                                             )
                                                                                                                                   ) 
                                                                                                                                 ) 
                                                                                                       ) 
                                                                                                    )
                                                                           ) 
                                                                        )
                                               ) 
                                            )     
   )                                                                                                                                  RES_PARENT_NODE_NAME_3

,NVL(decode(DEPTH,4,PARENT_PK1_VALUE,'') ,NVL(
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 4
                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                               )   
                                               ,
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 4
                                                and xxx.TREE_NODE_ID = NVL(
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 5
                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                           )   
                                                                           ,
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 5
                                                                            and xxx.TREE_NODE_ID = NVL(
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 6
                                                                                                        and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                       )   
                                                                                                       ,
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 6
                                                                                                        and xxx.TREE_NODE_ID = NVL(
                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                    where xxx.DEPTH = 7
                                                                                                                                    and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                   )   
                                                                                                                                   ,
                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                    where xxx.DEPTH = 7
                                                                                                                                    and xxx.TREE_NODE_ID = NVL(
                                                                                                                                                               (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                from FND_TREE_NODE xxx
                                                                                                                                                                where xxx.DEPTH = 8
                                                                                                                                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                               )   
                                                                                                                                                               ,
                                                                                                                                                               (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                from FND_TREE_NODE xxx
                                                                                                                                                                where xxx.DEPTH = 8
                                                                                                                                                                and xxx.TREE_NODE_ID = (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                                                        from FND_TREE_NODE xxx
                                                                                                                                                                                        where xxx.DEPTH = 9
                                                                                                                                                                                        and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                                                        ) 
                                                                                                                                                               ) 
                                                                                                                                                             ) 
                                                                                                                                   ) 
                                                                                                                                 )
                                                                                                       ) 
                                                                                                     ) 
                                                                           ) 
                                                                        )
                                               ) 
                                            )    
   )                                                                                                                                   RES_PARENT_NODE_NAME_4

,NVL(decode(DEPTH,5,PARENT_PK1_VALUE,'') ,NVL(
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 5
                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                               )   
                                               ,
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 5
                                                and xxx.TREE_NODE_ID = NVL(
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 6
                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                           )   
                                                                           ,
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 6
                                                                            and xxx.TREE_NODE_ID = NVL(
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 7
                                                                                                        and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                       )   
                                                                                                       ,
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 7
                                                                                                        and xxx.TREE_NODE_ID = NVL(
                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                    where xxx.DEPTH = 8
                                                                                                                                    and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                   )   
                                                                                                                                   ,
                                                                                                                                   (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                    from FND_TREE_NODE xxx
                                                                                                                                    where xxx.DEPTH = 8
                                                                                                                                    and xxx.TREE_NODE_ID = (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                                            from FND_TREE_NODE xxx
                                                                                                                                                            where xxx.DEPTH = 9
                                                                                                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                                            ) 
                                                                                                                                   ) 
                                                                                                                                 ) 
                                                                                                       ) 
                                                                                                     )
                                                                           ) 
                                                                         ) 
                                               ) 
                                            )    
   )                                                                                                                                  RES_PARENT_NODE_NAME_5

,NVL(decode(DEPTH,6,PARENT_PK1_VALUE,''), NVL(
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 6
                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                               )   
                                               ,
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 6
                                                and xxx.TREE_NODE_ID = NVL(
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 7
                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                           )   
                                                                           ,
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 7
                                                                            and xxx.TREE_NODE_ID = NVL(
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 8
                                                                                                        and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                       )   
                                                                                                       ,
                                                                                                       (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                        from FND_TREE_NODE xxx
                                                                                                        where xxx.DEPTH = 8
                                                                                                        and xxx.TREE_NODE_ID = (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                                                from FND_TREE_NODE xxx
                                                                                                                                where xxx.DEPTH = 9
                                                                                                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                                                ) 
                                                                                                       ) 
                                                                                                     ) 
                                                                           ) 
                                                                         )
                                               ) 
                                             )   
    )                                                                                                                                 RES_PARENT_NODE_NAME_6

,NVL(decode(DEPTH,7,PARENT_PK1_VALUE,'') ,NVL(
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 7
                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                               )   
                                               ,
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 7
                                                and xxx.TREE_NODE_ID = NVL(
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 8
                                                                            and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                           )   
                                                                           ,
                                                                           (select distinct xxx.PARENT_TREE_NODE_ID
                                                                            from FND_TREE_NODE xxx
                                                                            where xxx.DEPTH = 8
                                                                            and xxx.TREE_NODE_ID = (select distinct xxx.PARENT_TREE_NODE_ID
                                                                                                    from FND_TREE_NODE xxx
                                                                                                    where xxx.DEPTH = 9
                                                                                                    and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                                                    ) 
                                                                           ) 
                                                                         ) 
                                               ) 
                                             )      
    )                                                                                                                                 RES_PARENT_NODE_NAME_7

,NVL(decode(DEPTH,8,PARENT_PK1_VALUE,''),NVL(
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 8
                                                and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                               )   
                                               ,
                                               (select distinct xxx.PARENT_PK1_VALUE
                                                from FND_TREE_NODE xxx
                                                where xxx.DEPTH = 8
                                                and xxx.TREE_NODE_ID = (select distinct xxx.PARENT_TREE_NODE_ID
                                                                        from FND_TREE_NODE xxx
                                                                        where xxx.DEPTH = 9
                                                                        and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                                                        ) 
                                               ) 
                                             )   
    )                                                                                                                                 RES_PARENT_NODE_NAME_8

,NVL(decode(DEPTH,9,PARENT_PK1_VALUE,'') ,(select distinct xxx.PARENT_PK1_VALUE
                                           from FND_TREE_NODE xxx
                                           where xxx.DEPTH = 9
                                           and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
                                          )    
    )                                                                                                                                 RES_PARENT_NODE_NAME_9

,decode(DEPTH,10,PARENT_PK1_VALUE,'')                                                                                                  RES_PARENT_NODE_NAME_10

,FndTreeNodeEO.PK1_START_VALUE                                                  RES_VALUE_FROM
,FndTreeNodeEO.PK1_END_VALUE                                                    RES_VALUE_TO
--,FndTreeNodeEO.PK2_START_VALUE                                                  RES_VALUESETCODE_FROM
--,FndTreeNodeEO.PK2_END_VALUE                                                    RES_VALUESETCODE_TO

,FndTreeNodeEO.LAST_UPDATED_BY   RSC_LAST_UPDATED_BY
,FndTreeNodeEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,FndTreeNodeEO.CREATED_BY RSC_CREATED_BY
,FndTreeNodeEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM FND_TREE_VL FndTreeEO
,FND_TREE_VERSION_VL FndTreeVersionEO
,FND_TREE_NODE FndTreeNodeEO
,(SELECT FndLableVlE0.LABEL_NAME
	,FndLableVlE0.TREE_STRUCTURE_CODE
	,FndTreeLabelE0.TREE_CODE
	,FndTreeLabelE0.TREE_LABEL_ID
	FROM FND_TREE_LABEL FndTreeLabelE0
	,FND_LABEL_VL FndLableVlE0
	WHERE FndTreeLabelE0.TREE_STRUCTURE_CODE = FndLableVlE0.TREE_STRUCTURE_CODE
	AND FndTreeLabelE0.DATA_SOURCE_ID = FndLableVlE0.DATA_SOURCE_ID
	AND FndTreeLabelE0.LABEL_PK3_VALUE = FndLableVlE0.LABEL_ID
	) LabelE0
WHERE FndTreeEO.Tree_code = FndTreeVersionEO.tree_code
AND FndTreeVersionEO.TREE_STRUCTURE_CODE = 'GL_ACCT_FLEX'
AND FndTreeVersionEO.TREE_STRUCTURE_CODE = FndTreeNodeEO.TREE_STRUCTURE_CODE
AND FndTreeVersionEO.TREE_VERSION_ID = FndTreeNodeEO.TREE_VERSION_ID
AND FndTreeNodeEO.TREE_STRUCTURE_CODE = LabelE0.TREE_STRUCTURE_CODE(+)
AND FndTreeNodeEO.TREE_CODE = LabelE0.TREE_CODE(+)
AND FndTreeNodeEO.TREE_LABEL_ID = LabelE0.TREE_LABEL_ID(+)
and DEPTH <= 10
--AND FndTreeNodeEO.TREE_VERSION_ID        = '586A42AB138B98F8E05355ACBCC0461C'
and (FndTreeNodeEO.PK1_START_VALUE is not null and FndTreeNodeEO.PK1_END_VALUE is not null)
ORDER BY FNDTREEEO.TREE_NAME
,FndTreeVersionEO.TREE_VERSION_NAME
,RES_PARENT_NODE_NAME_1
,RES_PARENT_NODE_NAME_2,RES_PARENT_NODE_NAME_3,RES_PARENT_NODE_NAME_4 ,RES_PARENT_NODE_NAME_5
,RES_PARENT_NODE_NAME_6,RES_PARENT_NODE_NAME_7,RES_PARENT_NODE_NAME_8,RES_PARENT_NODE_NAME_9,RES_PARENT_NODE_NAME_10 





