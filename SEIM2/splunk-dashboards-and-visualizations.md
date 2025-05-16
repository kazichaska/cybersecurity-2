````markdown
# Splunk Dashboards and Visualizations Guide

## 1. Basic Visualizations

### Single-Value Visualization
```splunk
# Total Failed Logins Today
sourcetype=access_* status=failed
| stats count as total_fails
```

Visualization Settings:
- Type: Single Value
- Title: "Failed Login Count"
- Color Range: Green (<100), Yellow (100-500), Red (>500)

### Multiple-Value Visualization
```splunk
# Top 5 IPs by Login Attempts
sourcetype=access_* 
| stats count by src_ip
| sort -count
| head 5
```

Visualization Settings:
- Type: Bar Chart
- X-Axis: src_ip
- Y-Axis: count
- Title: "Top Login Sources"

## 2. Geographic Visualizations

### Basic Location Mapping
```splunk
# Map Login Locations
sourcetype=access_*
| iplocation src_ip
| geostats count by latitude longitude
```

Visualization Settings:
- Type: Choropleth Map
- Center: 0,0
- Zoom: World View

### Country-Based Analysis
```splunk
# Login Attempts by Country
sourcetype=access_*
| iplocation src_ip
| stats count by Country
| sort -count
```

Visualization Settings:
- Type: World Map
- Location Field: Country
- Value Field: count

## 3. Combined Dashboard Example

### Dashboard XML
```xml
<dashboard>
  <label>Security Overview</label>
  <row>
    <panel>
      <title>Failed Logins Today</title>
      <single>
        <search>
          <query>sourcetype=access_* status=failed | stats count</query>
        </search>
      </single>
    </panel>
    <panel>
      <title>Login Sources</title>
      <map>
        <search>
          <query>
            sourcetype=access_* 
            | iplocation src_ip 
            | geostats count
          </query>
        </search>
      </map>
    </panel>
  </row>
</dashboard>
```

## 4. Interactive Features

### Time Range Selector
```xml
<form>
  <label>Security Dashboard</label>
  <fieldset>
    <input type="time" token="time_range">
      <label>Time Range</label>
      <default>
        <earliest>-24h@h</earliest>
        <latest>now</latest>
      </default>
    </input>
  </fieldset>
</form>
```

### Drilldown Example
```splunk
# Click IP to see details
sourcetype=access_* 
| stats count by src_ip
| sort -count
| head 10
```

Drilldown Settings:
- Action: Link to Search
- Target: New Window
- Search: sourcetype=access_* src_ip=$click.value$

## Best Practices

1. **Visualization Selection**
   - Use appropriate chart types
   - Keep it simple
   - Consider color-blind users
   - Use consistent formatting

2. **Dashboard Organization**
   - Most important panels on top
   - Related visualizations together
   - Clear, descriptive titles
   - Logical flow of information

3. **Interactive Elements**
   - Add useful time selectors
   - Include relevant filters
   - Meaningful drilldowns
   - Help text where needed

## Sample Dashboard Layout
```
+------------------------+------------------------+
|    Failed Logins       |    Geographic View    |
|    [Single Value]      |    [World Map]        |
+------------------------+------------------------+
|           Top Sources by Country               |
|           [Column Chart]                       |
+------------------------+------------------------+
|    Hourly Trend        |    Attack Types       |
|    [Line Chart]        |    [Pie Chart]        |
+------------------------+------------------------+
```
````