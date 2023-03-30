/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

WITH RATE_COLUMN AS (SELECT CATEGORY_CD
    ,1 SEQ
    ,PRMRY_RT_LABEL LABEL
    ,DSPLY_ANN_PRMRY_RT FLAG
    FROM BEN_BNFT_CATEGORY
    
    UNION
    
    SELECT CATEGORY_CD
    ,2 SEQ
    ,SCNDRY_RT_LABEL LABEL
    ,DSPLY_SCNDRY_RT FLAG
    FROM BEN_BNFT_CATEGORY
    
    UNION
    
    SELECT CATEGORY_CD
    ,3 SEQ
    ,OTHR_PRETAX_RT_LABEL LABEL
    ,DSPLY_OTHR_PRETAX_RT FLAG
    FROM BEN_BNFT_CATEGORY
    
    UNION
    
    SELECT CATEGORY_CD
    ,4 SEQ
    ,OTHR_AFTERTAX_RT_LABEL LABEL
    ,DSPLY_OTHR_AFTERTAX_RT FLAG
    FROM BEN_BNFT_CATEGORY
    )

SELECT configPlanTypesE0.USER_NAME RES_ENROLLMENT_DISPLAY_NAME
,rateColumnsE0.SEQ RES_COLUMN
,rateColumnsE0.LABEL RES_DISPLAY_NAME
,DECODE(rateColumnsE0.FLAG,'Y','Yes','No') RES_DISPLAY
,configPlanTypesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,configPlanTypesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,configPlanTypesE0.CREATED_BY RSC_CREATED_BY
,configPlanTypesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  
FROM BEN_BNFT_CATEGORY configPlanTypesE0
,RATE_COLUMN rateColumnsE0
WHERE configPlanTypesE0.USAGE_CD = 'SS'
AND configPlanTypesE0.CATEGORY_CD = rateColumnsE0.CATEGORY_CD
ORDER BY configPlanTypesE0.USER_NAME
,rateColumnsE0.SEQ