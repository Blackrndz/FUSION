/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-09-26  $:
 * $HeadURL:  $:
 * $Id: Manage Account Hierarchies - Tree Version Specify Nodes (Values from referenced hierarchy) $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT RES_TREE_NAME,
  RES_TREE_CODE,
  RES_TREE_STRUCTURE_CODE,
  RES_NAME,
  RES_TREE_NODE_TYPE,
  RES_PARENT_NODE_NAME_1,
  RES_PARENT_NODE_NAME_2,
  RES_PARENT_NODE_NAME_3,
  RES_PARENT_NODE_NAME_4,
  RES_PARENT_NODE_NAME_5,
  RES_PARENT_NODE_NAME_6,
  RES_PARENT_NODE_NAME_7,
  RES_PARENT_NODE_NAME_8,
  RES_PARENT_NODE_NAME_9,
  RES_PARENT_NODE_NAME_10,
  RES_REFERENCED_TREE,
  RES_REFERENCED_TREE_VERSION_ID,
  RES_REFERENCED_TREE_VERSION,
  RSC_LAST_UPDATED_BY,
  RSC_LAST_UPDATE_DATE,
  RSC_CREATED_BY,
  RSC_CREATION_DATE,
  RSC_LEDGER_ID,
  RSC_CHART_OF_ACCOUNTS_ID,
  RSC_BUSINESS_UNIT_ID,
  RSC_LEGAL_ENTITY_ID,
  RSC_ORGANIZATION_ID,
  RSC_BUSINESS_GROUP_ID,
  RSC_ENTERPRISE_ID,
  RSC_COUNTRY_ID
FROM
(
	Select HEAD.*
	,ROW_NUMBER() OVER (PARTITION BY  RES_TREE_NAME ,RES_TREE_CODE ,RES_TREE_STRUCTURE_CODE,RES_NAME,RES_REFERENCED_TREE_VERSION,RES_PARENT_NODE_NAME_1,RES_PARENT_NODE_NAME_2
						,RES_PARENT_NODE_NAME_3,RES_PARENT_NODE_NAME_4,RES_PARENT_NODE_NAME_5
						,RES_PARENT_NODE_NAME_6,RES_PARENT_NODE_NAME_7,RES_PARENT_NODE_NAME_8,RES_PARENT_NODE_NAME_9,RES_PARENT_NODE_NAME_10
					   ORDER BY RSC_LAST_UPDATE_DATE  
					   )                                                            	AS RES_SEQUENCE_NUMBER /* PD don't need duplicate record */
	FROM
	(

		SELECT 
		 DISTINCT FndTreeEO.TREE_NAME                                                   RES_TREE_NAME
		,FndTreeEO.TREE_CODE                                                            RES_TREE_CODE
		,FndTreeEO.TREE_STRUCTURE_CODE                                                  RES_TREE_STRUCTURE_CODE
		,FndTreeVersionEO.TREE_VERSION_NAME                                             RES_NAME
		,'Values from referenced hierarchy'                                             RES_TREE_NODE_TYPE
		,nvl(decode(DEPTH,1,PARENT_PK1_VALUE,'')   , NVL(
														(select distinct xxx.PARENT_PK1_VALUE
														 from FND_TREE_NODE xxx
														 where xxx.DEPTH = 1
														 and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
														 ) 
														 ,
														 (select distinct xxx.PARENT_PK1_VALUE
														 from FND_TREE_NODE xxx
														 where xxx.DEPTH = 1
														 and xxx.TREE_NODE_ID =  NVL(
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
																												   and xxx.TREE_NODE_ID =  NVL(
																																			  (select distinct xxx.PARENT_TREE_NODE_ID
																																			   from FND_TREE_NODE xxx
																																			   where xxx.DEPTH = 4
																																			   and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
																																			   ) 
																																			   ,
																																			   (select distinct xxx.PARENT_TREE_NODE_ID
																																			   from FND_TREE_NODE xxx
																																			   where xxx.DEPTH = 4
																																			   and xxx.TREE_NODE_ID =  NVL(
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
		
		  )                                                                                                                               RES_PARENT_NODE_NAME_1,
		
		nvl(decode(DEPTH,2,PARENT_PK1_VALUE,'') , NVL(
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
																					 and xxx.TREE_NODE_ID =  NVL(
																												(select distinct xxx.PARENT_TREE_NODE_ID
																												 from FND_TREE_NODE xxx
																												 where xxx.DEPTH = 4
																												 and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
																												 ) 
																												 ,
																												 (select distinct xxx.PARENT_TREE_NODE_ID
																												 from FND_TREE_NODE xxx
																												 where xxx.DEPTH = 4
																												 and xxx.TREE_NODE_ID =  NVL(
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
		   )                                                                                                                              RES_PARENT_NODE_NAME_2,
												   
		nvl(decode(DEPTH,3,PARENT_PK1_VALUE,''), NVL(
														(select distinct xxx.PARENT_PK1_VALUE
														 from FND_TREE_NODE xxx
														 where xxx.DEPTH = 3
														 and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
														 ) 
														 ,
														 (select distinct xxx.PARENT_PK1_VALUE
														 from FND_TREE_NODE xxx
														 where xxx.DEPTH = 3
														 and xxx.TREE_NODE_ID =  NVL(
																					(select distinct xxx.PARENT_TREE_NODE_ID
																					 from FND_TREE_NODE xxx
																					 where xxx.DEPTH = 4
																					 and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
																					 ) 
																					 ,
																					 (select distinct xxx.PARENT_TREE_NODE_ID
																					 from FND_TREE_NODE xxx
																					 where xxx.DEPTH = 4
																					 and xxx.TREE_NODE_ID =  NVL(
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
		   )                                                                                                                              RES_PARENT_NODE_NAME_3,
		
		nvl(decode(DEPTH,4,PARENT_PK1_VALUE,'')  , NVL(
														(select distinct xxx.PARENT_PK1_VALUE
														 from FND_TREE_NODE xxx
														 where xxx.DEPTH = 4
														 and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
														 ) 
														 ,
														 (select distinct xxx.PARENT_PK1_VALUE
														 from FND_TREE_NODE xxx
														 where xxx.DEPTH = 4
														 and xxx.TREE_NODE_ID =  NVL(
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
		   )                                                                                                                              RES_PARENT_NODE_NAME_4,
		
		nvl(decode(DEPTH,5,PARENT_PK1_VALUE,'') , NVL(
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
		   )                                                                                                                              RES_PARENT_NODE_NAME_5,
		
		nvl(decode(DEPTH,6,PARENT_PK1_VALUE,'')  , NVL(
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
		   )                                                                                                                              RES_PARENT_NODE_NAME_6,
		
		nvl(decode(DEPTH,7,PARENT_PK1_VALUE,'')  , NVL(
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
		   )                                                                                                                              RES_PARENT_NODE_NAME_7,
		
		nvl(decode(DEPTH,8,PARENT_PK1_VALUE,'')  ,  NVL(
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
		   )                                                                                                                              RES_PARENT_NODE_NAME_8,
		
		nvl(decode(DEPTH,9,PARENT_PK1_VALUE,'')  , (select distinct xxx.PARENT_PK1_VALUE
												   from FND_TREE_NODE xxx
												   where xxx.DEPTH = 9
												   and xxx.TREE_NODE_ID = FndTreeNodeEO.PARENT_TREE_NODE_ID
												   )  
		   )                                                                                                                              RES_PARENT_NODE_NAME_9,
		
		decode(DEPTH,10,PARENT_PK1_VALUE,'')                                                                                               RES_PARENT_NODE_NAME_10
		
		,/*(select  FndTreeVersionEO.TREE_VERSION_NAME 
		  FROM FND_TREE_VERSION_VL FndTreeVersionEO
		  where  FndTreeVersionEO.TREE_VERSION_ID    =  FndTreeNodeEO.REFERENCE_TREE_VERSION_ID 
		  ) */ FndTreeEO.TREE_NAME                                                                            	RES_REFERENCED_TREE
		
		,REFERENCE_TREE_VERSION_ID                                                      						RES_REFERENCED_TREE_VERSION_ID
		 ,(select  FndTreeVersionEO.TREE_VERSION_NAME 
		  FROM FND_TREE_VERSION_VL FndTreeVersionEO
		  where  FndTreeVersionEO.TREE_VERSION_ID    =  FndTreeNodeEO.REFERENCE_TREE_VERSION_ID 
		  )                                                                           							RES_REFERENCED_TREE_VERSION
		
		
		,FndTreeNodeEO.LAST_UPDATED_BY                                              RSC_LAST_UPDATED_BY
		,FndTreeNodeEO.LAST_UPDATE_DATE                                             RSC_LAST_UPDATE_DATE
		,FndTreeNodeEO.CREATED_BY                                                   RSC_CREATED_BY
		,FndTreeNodeEO.CREATION_DATE                                                RSC_CREATION_DATE
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
	 
		WHERE FndTreeEO.Tree_code = FndTreeVersionEO.tree_code
		AND FndTreeVersionEO.TREE_STRUCTURE_CODE = 'GL_ACCT_FLEX'
		AND FndTreeVersionEO.TREE_STRUCTURE_CODE = FndTreeNodeEO.TREE_STRUCTURE_CODE
		AND FndTreeVersionEO.TREE_VERSION_ID = FndTreeNodeEO.TREE_VERSION_ID
		and FndTreeNodeEO.PK1_START_VALUE is null
		and DEPTH <= 10
	   -- AND FndTreeNodeEO.TREE_VERSION_ID        = '586A42AB138B98F8E05355ACBCC0461C'
	   
	) HEAD
)
WHERE RES_SEQUENCE_NUMBER = 1
ORDER BY RES_TREE_NAME,RES_NAME ,RES_PARENT_NODE_NAME_1
    ,RES_PARENT_NODE_NAME_2,RES_PARENT_NODE_NAME_3,RES_PARENT_NODE_NAME_4 ,RES_PARENT_NODE_NAME_5
	,RES_PARENT_NODE_NAME_6,RES_PARENT_NODE_NAME_7,RES_PARENT_NODE_NAME_8,RES_PARENT_NODE_NAME_9,RES_PARENT_NODE_NAME_10 

