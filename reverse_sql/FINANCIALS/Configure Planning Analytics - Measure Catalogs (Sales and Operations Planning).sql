/* ****************************************************************************
 * $Revision: 78481 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-05-13 13:04:02 +0700 (Fri, 13 May 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Configure%20Planning%20Analytics%20-%20Measure%20Catalogs%20(Sales%20and%20Operations%20Planning).sql $:
 * $Id: Configure Planning Analytics - Measure Catalogs (Sales and Operations Planning).sql 78481 2022-05-13 06:04:02Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=MSC_MEASURE_CATALOGS_VL

SELECT MeasureCatalogsE0.NAME RES_MEASURE_CATALOG_NAME
,MeasureCatalogsE0.DESCRIPTION RES_DESCRIPTION
,'' RES_STATUS
,DECODE(MeasureCatalogsE0.IS_SOP_DEF_CATALOG,1,'Yes','No') RES_SALES_AND_OPERATIONS_PLANN
,MeasureCatalogsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,MeasureCatalogsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,MeasureCatalogsE0.CREATED_BY  RSC_CREATED_BY
,MeasureCatalogsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM MSC_MEASURE_CATALOGS_VL MeasureCatalogsE0
ORDER BY 1